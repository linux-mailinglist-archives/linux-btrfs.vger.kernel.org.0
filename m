Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C90561A39
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jun 2022 14:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbiF3MVi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jun 2022 08:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbiF3MVh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jun 2022 08:21:37 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7F820F4D
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jun 2022 05:21:36 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g20-20020a17090a579400b001ed52939d72so2659593pji.4
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jun 2022 05:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=lbYoREvmzql9lYj8aM58YAT4aurGaSf+5cLoACdtQTo=;
        b=AwQWGTsm0Vh3YYS6d/tE0fktE8C+ieT3zwVRsV32gyT67P/2L1YHz0MqSFiyyXQtqv
         A6SWL+btCsqV/1cmgqY9cMX02Uy4eukN7ryVwQSuaIX3oZSBSvxTHpJ45uA3F+SaAaaL
         pxkOHFb1n/GcZ764bZpjYSRHoAfvicqCyM1cQwTwgef9m1EewGfv0UIY2tmnJZa7QRLG
         k1AlzaRd/yn1AV8SzgAIolxs4vpOVPhRn4kgCns0jdHyj2PK9ZK7JaQQT0lDHMfr54b+
         RPU0OtDEL/v4x+2kXHmfYWBgWMVA6nosuEkGDpW4/DUGyBwJrDpa/askj5p44DIx/NnJ
         LjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lbYoREvmzql9lYj8aM58YAT4aurGaSf+5cLoACdtQTo=;
        b=m6aaKT4UV4UwfaGj3aGJhu1hl1hfjfSI0FbH3hd67VbjTphQ9fzGCgZuKWs/g7x+f4
         PQXDimmb7rVpa0TqtIlz+b3qLXy12Qi5CzvkaV4XF/9viIJzd6g6e/avYoPlBM2Zc/o9
         a9yKVZqVir8bc6zH4z1xx8pg6/G6kmO09cBt0mSLvIvli06YFZJQKJFSV7lx7V56Jnp5
         LQbiYqSEZCjzlKqn7zrqZyfLYGeK95z2ujkicXx8KxkqdYbu9gsr2mONTbrcL675mpqw
         r6pTT9oZOo8qrxG4Nw2ZKh88SYnccGhIz7khBnN2bCtTBkfqUv+0MHcQB4nlCjeAn66g
         ue6w==
X-Gm-Message-State: AJIora97tjqRca6YBTpggT+wMDiXElIYdAmfzMU2qGhuJSrLY4h2tBql
        5pRCrKpXakBYnh2Kqc8x7tgWNQGk8tWTZg==
X-Google-Smtp-Source: AGRyM1teyPzDASWD2AOc8A5z5MCL2FmhumEw4bgn4mZq0g242lrPVc0u/uaIgEqI+fZpma4tgUrp7Q==
X-Received: by 2002:a17:90b:3b41:b0:1ed:25b1:e53a with SMTP id ot1-20020a17090b3b4100b001ed25b1e53amr12175390pjb.71.1656591695860;
        Thu, 30 Jun 2022 05:21:35 -0700 (PDT)
Received: from [192.168.50.25] ([150.107.0.182])
        by smtp.gmail.com with ESMTPSA id c22-20020a170902b69600b0016b82943821sm7607851pls.73.2022.06.30.05.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 05:21:35 -0700 (PDT)
Message-ID: <fe4a2475-f8c3-8e66-82db-7ee20922713f@gmail.com>
Date:   Thu, 30 Jun 2022 20:21:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 8/8] fs: erofs: add unaligned read range handling
To:     Qu Wenruo <wqu@suse.com>, u-boot@lists.denx.de
Cc:     marek.behun@nic.cz, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, trini@konsulko.com,
        joaomarcos.costa@bootlin.com, thomas.petazzoni@bootlin.com,
        miquel.raynal@bootlin.com
References: <cover.1656502685.git.wqu@suse.com>
 <f1f81773bf816717089d2ffde1ce673f5bb25e1e.1656502685.git.wqu@suse.com>
From:   Huang Jianan <jnhuang95@gmail.com>
In-Reply-To: <f1f81773bf816717089d2ffde1ce673f5bb25e1e.1656502685.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



在 2022/6/29 19:38, Qu Wenruo 写道:
> I'm not an expert on erofs, but my quick glance didn't expose any
> special handling on unaligned range, thus I think the U-boot erofs
> driver doesn't really support unaligned read range.
> 
> This patch will add erofs_get_blocksize() so erofs can benefit from the
> generic unaligned read support.
> 
> Cc: Huang Jianan <jnhuang95@gmail.com>
> Cc: linux-erofs@lists.ozlabs.org
> Signed-off-by: Qu Wenruo <wqu@suse.com>
Looks good to me,

Reviewed-by: Huang Jianan <jnhuang95@gmail.com>

Thanks,
Jianan
> ---
>   fs/erofs/internal.h | 1 +
>   fs/erofs/super.c    | 6 ++++++
>   fs/fs.c             | 2 +-
>   include/erofs.h     | 1 +
>   4 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 4af7c91560cc..d368a6481bf1 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -83,6 +83,7 @@ struct erofs_sb_info {
>   	u16 available_compr_algs;
>   	u16 lz4_max_distance;
>   	u32 checksum;
> +	u32 blocksize;
>   	u16 extra_devices;
>   	union {
>   		u16 devt_slotoff;		/* used for mkfs */
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 4cca322b9ead..df01d2e719a7 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -99,7 +99,13 @@ int erofs_read_superblock(void)
>   
>   	sbi.build_time = le64_to_cpu(dsb->build_time);
>   	sbi.build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
> +	sbi.blocksize = 1 << blkszbits;
>   
>   	memcpy(&sbi.uuid, dsb->uuid, sizeof(dsb->uuid));
>   	return erofs_init_devices(&sbi, dsb);
>   }
> +
> +int erofs_get_blocksize(const char *filename)
> +{
> +	return sbi.blocksize;
> +}
> diff --git a/fs/fs.c b/fs/fs.c
> index 61bae1051406..e92174d89c28 100644
> --- a/fs/fs.c
> +++ b/fs/fs.c
> @@ -375,7 +375,7 @@ static struct fstype_info fstypes[] = {
>   		.readdir = erofs_readdir,
>   		.ls = fs_ls_generic,
>   		.read = erofs_read,
> -		.get_blocksize = fs_get_blocksize_unsupported,
> +		.get_blocksize = erofs_get_blocksize,
>   		.size = erofs_size,
>   		.close = erofs_close,
>   		.closedir = erofs_closedir,
> diff --git a/include/erofs.h b/include/erofs.h
> index 1fbe82bf72cb..18bd6807c538 100644
> --- a/include/erofs.h
> +++ b/include/erofs.h
> @@ -10,6 +10,7 @@ int erofs_probe(struct blk_desc *fs_dev_desc,
>   		struct disk_partition *fs_partition);
>   int erofs_read(const char *filename, void *buf, loff_t offset,
>   	       loff_t len, loff_t *actread);
> +int erofs_get_blocksize(const char *filename);
>   int erofs_size(const char *filename, loff_t *size);
>   int erofs_exists(const char *filename);
>   void erofs_close(void);
