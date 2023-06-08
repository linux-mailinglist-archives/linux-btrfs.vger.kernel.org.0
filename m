Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8927772772B
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 08:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjFHGSX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 02:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbjFHGSS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 02:18:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602FF1FDF
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 23:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686205091; x=1686809891; i=quwenruo.btrfs@gmx.com;
 bh=AcRaZ9FoU6F3yt6OO+fMVSgSC4rsBC991zzxdaDsfmo=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=e5BjH4BapslLOdB7nqNfQ9CAAtbGP3NUZEeUr0hW6XXzYEADPJlVjqOiVvWhFBTt0s/ijRt
 ntj/Xof2SdVsttl3xYdzt4kOpS5CI+dqLS3mVagh5HBeYh+0fXxA0LiFHKhctep1YG9S13y4L
 II0ZVDxl/b5McUMBhu+c23fk4vXsRKUyHpqfPbNyVgv2WxATgdpD0IFFQUGMXMewN1Kq1wgjM
 5ZSTOe3GKb5Q4KeLG7i+pbUhfTR49sosQceVq7NReeTU587IkCuWEZ0W6vvT08rTRuco13tQx
 NWZCbTr6GEFMY29c8pr7n5Q/rwFR1WXvMBK/brI4A5w064arp4tQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXp9Y-1qf8OM2uZo-00YCc0; Thu, 08
 Jun 2023 08:18:11 +0200
Message-ID: <3e6589ae-5d1c-8911-8680-576ece238bd2@gmx.com>
Date:   Thu, 8 Jun 2023 14:18:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 4/7] btrfs-progs: device_list_add: optimize arguments drop
 devid
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1686202417.git.anand.jain@oracle.com>
 <6b296396c512a2dd7cb024575a35a6e0c1132a14.1686202417.git.anand.jain@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <6b296396c512a2dd7cb024575a35a6e0c1132a14.1686202417.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KJu0rvb2dmzAQaPJigThWdtq3R2oCgbLjT8VeERUlGy+ir1NQNR
 qaKrVHiVGdHvwtdOtMq9nb8hfTl5TdsUpBQjsSbh30koFVmOg+xlxfckDQA9abLIHrRRWeS
 sMTgnwFog6D2MgELGwLMdU/8xHruC/qk8MKG7RSARIi53hKB+JQKqr4WMhS2awrvxKXN2Fp
 6BVml6+MIGbPzMH8kolYw==
UI-OutboundReport: notjunk:1;M01:P0:8ZxszIN4cV4=;1hhaTMyMBiseM8TvKHpo+CindsV
 893o9GgSrrsvnz14ukR+3N+QTkI89fOmSdwQ4/tbZvppwPMm3siiFwPrfUL+hHzNMkJq+eQgZ
 bC5IvCi90PcHtbTOSPtrt0FSa3pHq9smhau3jvoEBiPCE2uhyny458ilRH1427PbgKw9LyoK3
 GGC0gBAeRPez0X7dx/W/aNVT6BRf7Oit/buqUJ6tJE6ljy4lmL5wd3Gfui95WWwv0cP51pXOh
 lJRI+4MqKvqn2r6qmdMkxxSEDE86HvuBfB3oqk049LZkzBsF4fUmYUvCp5wjCkM2jrk+IDkC0
 ql/t6d+sf1iwp88RGWDz9+qhXCv1hRUhvyPYrcLPq6CvXuFt8RkxMkeCHT3g8TbIEtPtj0B+b
 bNuFpSEiUYiX/ANEcH0QatRybq2NjEsqH8LFLNolzqwFUKKz8rFV1GFZ3TgwJF1m9QIA8Jgku
 gV3cE+/dizQk2Dt197dM7ehwm2M745WNFezl39M6B9fD/zZPUJfhgijHtOqnFQQmTkDfowWxj
 dRDi93v5RBXGRxbJd2WnxZzGrILWY22Nsh9qrKax/m/ry+90dCX/4movUvLYBQctAXQXnTG4e
 EBaGnmTT2z/5dq53iS2d3SkuoAmJenDqZ79IgwIQ1quZ3Ynb0EeIZhTD3WrDWR1nfZCiXdEcT
 9mjjuFhXQNYiOFCxoUgRkkjWTjCQMrPyHs84sWs/NrxHOZsKEwGG93JGk/BzEnhu5U3hlJax0
 xLTi+0KO4X3OEVNd/qy3F3TllcN02aBo/enYI9OR9zdTLAzf+1xJXQNLjxASeWztTLbCMvQco
 Rxv5yICcuMgJBRmXhVlaG46ib2k/SKeiT2g+GWe3Py9YvpYbQfZoTsmA4pydYsSRkxegWo26h
 /rjPA3ZfVJNAPXPH21qdNR0gPaWWy/CTOZAK3oD/MWnC/HJ7Qh5NeOOftZ7mn6jDSqarrpBS4
 Vh7K2rcfjht7yOXefQ1BdR/zBuE=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/8 14:01, Anand Jain wrote:
> Drop the devid argument; instead, it can be fetched from the disk_super
> argument. >
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   kernel-shared/volumes.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
> index 95d5930b95d8..81abda3f7d1c 100644
> --- a/kernel-shared/volumes.c
> +++ b/kernel-shared/volumes.c
> @@ -334,11 +334,12 @@ static struct btrfs_fs_devices *find_fsid(u8 *fsid=
, u8 *metadata_uuid)
>
>   static int device_list_add(const char *path,
>   			   struct btrfs_super_block *disk_super,
> -			   u64 devid, struct btrfs_fs_devices **fs_devices_ret)
> +			   struct btrfs_fs_devices **fs_devices_ret)
>   {
>   	struct btrfs_device *device;
>   	struct btrfs_fs_devices *fs_devices;
>   	u64 found_transid =3D btrfs_super_generation(disk_super);
> +	u64 devid =3D btrfs_stack_device_id(&disk_super->dev_item);
>   	bool metadata_uuid =3D (btrfs_super_incompat_flags(disk_super) &
>   		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
>
> @@ -545,18 +546,17 @@ int btrfs_scan_one_device(int fd, const char *path=
,
>   {
>   	struct btrfs_super_block disk_super;
>   	int ret;
> -	u64 devid;
>
>   	ret =3D btrfs_read_dev_super(fd, &disk_super, super_offset, sbflags);
>   	if (ret < 0)
>   		return -EIO;
> -	devid =3D btrfs_stack_device_id(&disk_super.dev_item);
> +
>   	if (btrfs_super_flags(&disk_super) & BTRFS_SUPER_FLAG_METADUMP)
>   		*total_devs =3D 1;
>   	else
>   		*total_devs =3D btrfs_super_num_devices(&disk_super);
>
> -	ret =3D device_list_add(path, &disk_super, devid, fs_devices_ret);
> +	ret =3D device_list_add(path, &disk_super, fs_devices_ret);
>
>   	return ret;
>   }
