Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1099F73F481
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jun 2023 08:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjF0G06 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 02:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjF0G01 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 02:26:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901791BFB
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jun 2023 23:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1687847177; x=1688451977; i=quwenruo.btrfs@gmx.com;
 bh=3L4YkmD3Md8S5crWrJ9801aKf6sazMduyJdIfMNE/ww=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=gTQj+0NqgRAZp7ITU/hZz9ySaVLVkCTy7t++9NaUsB7wYaQT05KGe7g0CiHqouJg0FSFG2C
 I1VtC4BBv6A1KpebSR+ujUAu0naIVYAW1O8GOwjvhveRtCbeTaW4C7ARQm2AqiRZVtT9tcifc
 8Y2i+PSuSbLdsLDzcyOaxnE8gWPqkxiI+QeTP4JloE0Bw6HqXiponOTqCoiz7CrKubcFRWsxH
 rt8w6hoOK/6ldM4tugazqp5jc01dG6rhbVYgmfq3OmQvAG6b2xocuWNvVeAPLzv5soJyVI/oR
 zW720y0yL1dZPfDNAqWEHKys/UoXENhaUs6N/GuJ9myhuwrkuibA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Md6R1-1peQQ71D9f-00aHJC; Tue, 27
 Jun 2023 08:26:17 +0200
Message-ID: <bd7dfd7b-4057-4527-2409-30eddf04a889@gmx.com>
Date:   Tue, 27 Jun 2023 14:26:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] btrfs: simplify the no-bioc fast path condition in
 btrfs_map_block
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230627061324.85216-1-hch@lst.de>
 <20230627061324.85216-3-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230627061324.85216-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OGEIRhGeb2Q/3XeL81nQ2FiBbQoZFJ80Di3MUXYStSVmLKXYQdM
 yvslJDcplLmJAfP/ySW8PWX0q0R1mGxzD0DOvz6fieN1axvxz4Q9Uo/CTGD3aavSXXt4T8a
 X1PRzRZrq1Cet03DUj7dyBXUMVWCcbOYorpcYGK56o3q72irgI1Ebwu6csWZeMeLG7PUp4c
 W23isPGok7nLNY0vi/rtg==
UI-OutboundReport: notjunk:1;M01:P0:sYO/Qkquqys=;Z7GclD3ULBiq7nCoclGsIhto2yN
 DPquJqJM/9vEF5+UEjy+lOtxutG1foiDWFi4Iy5X08S8d2sjg9j6ZqtoXAkfG+6/E7vtFX9gg
 f5+l+MrBByq9ToN/OEaiCwGmleDYpvZCcwYgiE3gN9Q7M3a0Q7QNO3nvOxkC2vDVrv0daFDPv
 s47ez07P3f/5WdgZjfrjADhrRoCS3ZEHDFwLxotmgfTFGP0UBT+WR32hlHiclC7Yx43fy/EeO
 hM4hUQSEq1q/hk1XJm/Ga3bd2Z+sIYinuHCiZvNwKFJMQzJs2JNujSUr40XaPSfEeG10JhwK+
 SBkBstYALVvJFJ24uw72eB1dbQeYmweF5v26LU15Q0D1RpUv+gTZJl76NyBGj/zqqy66yXaza
 fJQ4M3boiZdNGo9z3h4Xf1UGZH1ksVVakh5YJxL91EbNduGhjsrQJbIZn3X23E/tpvgIkEAhU
 EKOXoZAUiAPL9gY8FejxnAdkb2XvoLz8kH8tSihjn9Zvrcwjh+9zmfREvEmz5NBCa5/xeINNm
 GnSlhm1hrCTTyx6FMqLnzcoh0mGhTl/8LxpiHolDyLxv+Glqxssb/56n0ATPoeU23DosrQEg6
 N3hvK/TBBgRsvbdT3hIpjAYk+0Zc5eoVOC7v304R7IHXV2FU/2MpKWDTuJX0tpSNgKQrueCBV
 NOnVC81dM7uNIAQxTr1sATQTp3YOr2jKiSHo3mp7QRChglVhqJ6KibN+CtAa+LeasuEa7t9Sd
 qyPeUd8vwkoeqKjwQQU9cpUlHpXnsuhqoof8zU6RD+FriS4A+Ytw6Ac9GnWeztvQDW0R52wpC
 KM55C9U3loWdlcCKw0/PHngyJAERkCrG47MhHHspell2Mg4dEs+aIYXFVcIjssCsE90MxPZQN
 LfAh2U/6Uppk+toA7qTAFWg/lmy0/bpwKwdA2gOmi05fyG5PM76ngnGK7sjXxZfMwjFGUZSaT
 pC/RfK690MH0AoPoHuS4/k8kx8c=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/27 14:13, Christoph Hellwig wrote:
> nr_alloc_stripes can't be one if we are writing to a replacement device,
> as it is incremented for that case right above.  Remove the duplicate
> checks.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/volumes.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 0d386ed44279ce..4907ed9809109d 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6402,9 +6402,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info,=
 enum btrfs_map_op op,
>   	 * I/O context structure.
>   	 */
>   	if (smap && num_alloc_stripes =3D=3D 1 &&
> -	    !((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1) &=
&
> -	    (op =3D=3D BTRFS_MAP_READ || !dev_replace_is_ongoing ||
> -	     !dev_replace->tgtdev)) {
> +	    !((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1)) =
{
>   		set_io_stripe(smap, map, stripe_index, stripe_offset, stripe_nr);
>   		if (mirror_num_ret)
>   			*mirror_num_ret =3D mirror_num;
