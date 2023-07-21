Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D533475C4AC
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 12:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjGUKbl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 06:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjGUKbk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 06:31:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F4D1B6
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 03:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1689935494; x=1690540294; i=quwenruo.btrfs@gmx.com;
 bh=1XNPQ3k7eWpP3PV6PyiNhCnw19dT1Q+V6QP6W9DVcuY=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=fkRXBCjxj765W6uqHbh1a48B5BmGjAmQlFPH7bsFEkU8XptmkmHI0AKLNV4+c/+HStHttCu
 SRXGkIu4uogT3ZSNNVrCfo6sGQC1yGWpPU/Atc/89XA+mZYMv/YVlC/xFrIuF4jbwhngTb1Uy
 T1DUBC9u6AG2WaBf2a/45tiELHxUuwd0IrSusX6mzGRuI0zIIMMMn/euMiHSi8KvL4eNl0Rjr
 4Bq04eVWZnr7d/6oITUqZsdBCy5/eR8VIskmjldLLgf9eI+BmORvuAqJXiyM4wKkr4073edAz
 bLRoKCTJw8ilWQMOULBXTNXp+fxpN7NEubF2RKQRnKfjjwXjBn9w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6Udt-1qGRQn0xLN-006t5g; Fri, 21
 Jul 2023 12:18:57 +0200
Message-ID: <daf9ae95-384d-0b58-ee98-f9698c08a038@gmx.com>
Date:   Fri, 21 Jul 2023 18:18:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] btrfs: check if the transaction was aborted at
 btrfs_wait_for_commit()
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1689932501.git.fdmanana@suse.com>
 <ef39d239a3d444a4a9788d5690c7f570ba6b8d52.1689932501.git.fdmanana@suse.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ef39d239a3d444a4a9788d5690c7f570ba6b8d52.1689932501.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H1oUP+UEpx3yIgrwgSqB9bG1c4dXAE2nNJcX8c1Zo4J9X38liEg
 xSwotePKPfPXlc1rDUcQB2oD7Qvc7ZOuIudW56MvrdkLNQfhOL0pxvBroxGP8Tlsdgram+S
 85Hl3X9lMDc01/FmpMEMjuUF88GRW9gQp842og29gd7muGNZUFUExfDrnfghLj/bNI8oDb4
 CmtaAkSYDshb4T5wtoJ6w==
UI-OutboundReport: notjunk:1;M01:P0:ieUSK+fOBNI=;0DHKM/nGQUFQobIDCDFsEOnJJvS
 6IuCJP+iUH2MyWzbNVbmdwP3EBW8tWREw3EDDQ7v9EOldAnkZ54Vt03XCVeGFM22jz3y6+X4v
 i//JJ2EWewUKLj5lAj517z0fV1fYCEiCB8Sao5lIb4TEeslNrXkaT3N6BEUyM/vKm73bwPiDr
 py1F1S1PcHXNq9QFXz78Iq2DM88HkZJRvSQEZXXi/A8wjKHgHHehhLLBYxH6iTy55WDnlPt73
 b9UXPHfSRfPwoYbuUNZsDvDT3BWFMznGSRuajdNFJNArAJbdWc9BdR3rllt2UNO1etmRI1y9G
 k9Y43aXLhXBMNOm2fxqD93cBTPbuq84YwaXxTKzFTpkfMNNo2RZ8N/oJ0d4nYHGgT42Q1sMrb
 3dlol5jZeju1o2mADRDY2NSEqwuijuK7kKNPZKK1rXPAXdp5ENp6htuKZsQnZyM83swdrYY5h
 dmEGIT15mcWB7S/krx0/Q1HLJIe5eC5ZIsGPoiMQDoXHFDNpBT6paiGX7kCPTPayq6ZBmnTw9
 FBgqNxM4DkRCkTgiBk7iFJDB40kkZFKd5PfCllPyaJxCJeO9SIQUdwH0Umpo2Bb/euDdQZIHt
 A9JRgo8qBZZUQGFjFd+zi4iyX0480HJ32TZod39COl1eb+bI3135AQ7f9Jc4nIBvGYOi2ionS
 OMEX/Bbzg/oTlXwa1EAUCj5bmHE/5lXI8ha7ViIP2yQkGHBfrEg0TkYFOfzQyh1bK90K0wpUJ
 NlLGxxW63OfVixVQgh44flZOmvVkI533wcPfnefbgvxcor9Mx7dVPGcEmCR/50HTvsbrEbKZz
 yyMCsDVxG3oPi4JUrOCZQ1b0JSBVGk5XonKAdWR94IvzwZ9jbB3F5FbDx5uVWPC/iiI7LpPYJ
 L/wCjzcY2Eh0M9WLp9Nmlo1moBcoMolYXAr4wCXPiOEInk/NzAvsAkfyK/rpVE1k9IVCq5OHn
 M2FhbgMP/wJYF0IzoZJy4fN6FzE=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/21 17:49, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> At btrfs_wait_for_commit() we wait for a transaction to finish and then
> always return 0 (success) without checking if it was aborted, in which
> case the transaction didn't happen due to some critical error. Fix this
> by checking if the transaction was aborted.
>
> Fixes: 462045928bda ("Btrfs: add START_SYNC, WAIT_SYNC ioctls")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/transaction.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 4743882fa94b..8ab85465cdaa 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -931,6 +931,7 @@ int btrfs_wait_for_commit(struct btrfs_fs_info *fs_i=
nfo, u64 transid)
>   	}
>
>   	wait_for_commit(cur_trans, TRANS_STATE_COMPLETED);
> +	ret =3D cur_trans->aborted;
>   	btrfs_put_transaction(cur_trans);
>   out:
>   	return ret;
