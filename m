Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3124655E501
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 15:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbiF1NiR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jun 2022 09:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346584AbiF1NhU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jun 2022 09:37:20 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FDE31366
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jun 2022 06:37:16 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id cu16so19946822qvb.7
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jun 2022 06:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GTcKrabJVodGYTpD+K/ovzQ3VaeHrjTTo6nOF+sb8Eo=;
        b=ebZuBQlcci6BeWZMKFwt7KVx0R1HSMJSoQ60bi5QTLPB0ESqY+2G16c8UO7wjMvg1x
         VfYPUIFB5WW7cVrgco2an2x6W0ncdM3X1kf5A7DwiWdSfUaxSD4ia3U3kxtpMsnVFms/
         7URbn8PwvQmGp1JUONT+OKhvj8F6QvRuk8IFpS65czyKRXGQBf+05w16FwVsSanseBlu
         ixK459PozYq8mJ+bUT91Ct1NXI+8/8pTx+iGbgvJdQiXnPmcOVpeqJg4Pyjd64pI00pt
         CYiMWyxCYMN4xmtYzBy6x4Cwr+dlm1BA5j4HWhOy00HwkBgeYAXt4+U7dC8egbh54Hk6
         ZgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GTcKrabJVodGYTpD+K/ovzQ3VaeHrjTTo6nOF+sb8Eo=;
        b=NmCNSfPCxIjZ7PMeUJ9Dd+ZCYQFkmRds10mCIlqjaP7zlYCnU4DEPgZYv9y+xjvPFy
         Mus7v/sORTmGuvoTFQ0O/GIlyAxoh0L8z9REjaGfMyOVvpcZbIbidKy2/hGTW49r19ep
         smlep0MA4yJfsJoGWGWAKH0MFLYKMv8T0BES3QdyIBgAsDHXy+hpU+JoOVCJV2Khdepc
         yqrZc9LKK6P4xeFbBFi3FB/9PN80xD0f7iJbyt7c0F08gr47PTQXgsULkhsL5RQHTO/S
         iQKeWtoTVcPb4QGuQJ8yknx4r0/wsrJeNMLBYjvqh0yVx9n25XBaktWFuBRe1R93hwQ/
         SPYA==
X-Gm-Message-State: AJIora8l4McDrr9rmGPclTKg/Gmj/Pu+sc+qtoou/lfn8pG8XVGbJt/l
        5mrgZLUsEkAD53bhArts0hk=
X-Google-Smtp-Source: AGRyM1sry+pf4jEIu97OD3MiI+23p9xHH3GUoqKD47kDQv6h3ccrLWnsTZfqcQbA9Y8+jSHJiBTVKQ==
X-Received: by 2002:ac8:5dd2:0:b0:304:ea09:4688 with SMTP id e18-20020ac85dd2000000b00304ea094688mr12936783qtx.526.1656423435923;
        Tue, 28 Jun 2022 06:37:15 -0700 (PDT)
Received: from [192.168.1.201] (pool-173-73-95-180.washdc.fios.verizon.net. [173.73.95.180])
        by smtp.gmail.com with ESMTPSA id t16-20020a37aa10000000b006a760640118sm11015695qke.27.2022.06.28.06.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 06:37:15 -0700 (PDT)
Subject: Re: [PATCH 0/8] u-boot: fs: add generic unaligned read handling
To:     Qu Wenruo <wqu@suse.com>, u-boot@lists.denx.de
Cc:     marek.behun@nic.cz, linux-btrfs@vger.kernel.org,
        jnhuang95@gmail.com, linux-erofs@lists.ozlabs.org,
        trini@konsulko.com, joaomarcos.costa@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
References: <cover.1656401086.git.wqu@suse.com>
From:   Sean Anderson <seanga2@gmail.com>
Message-ID: <bb00b682-d1bf-0f72-df2a-fe5014a84ce6@gmail.com>
Date:   Tue, 28 Jun 2022 09:37:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <cover.1656401086.git.wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/28/22 3:28 AM, Qu Wenruo wrote:
> [BACKGROUND]
> Unlike FUSE/Kernel which always pass aligned read range, U-boot fs code
> just pass the request range to underlying fses.
> 
> Under most case, this works fine, as U-boot only really needs to read
> the whole file (aka, 0 for both offset and len, len will be later
> determined using file size).
> 
> But if some advanced user/script wants to extract kernel/initramfs from
> combined image, we may need to do unaligned read in that case.
> 
> [ADVANTAGE]
> This patchset will handle unaligned read range in _fs_read():
> 
> - Get blocksize of the underlying fs
> 
> - Read the leading block contianing the unaligned range
>    The full block will be stored in a local buffer, then only copy
>    the bytes in the unaligned range into the destination buffer.
> 
>    If the first block covers the whole range, we just call it aday.
> 
> - Read the aligned range if there is any
> 
> - Read the tailing block containing the unaligned range
>    And copy the covered range into the destination.
> 
> [DISADVANTAGE]
> There are mainly two problems:
> 
> - Extra memory allocation for every _fs_read() call
>    For the leading and tailing block.
> 
> - Extra path resolving
>    All those supported fs will have to do extra path resolving up to 2
>    times (one for the leading block, one for the tailing block).
>    This may slow down the read.
> 
> [SUPPORTED FSES]
> 
> - Btrfs (manually tested*)
> - Ext4 (manually tested)
> - FAT (manually tested)
> - Erofs
> - sandboxfs
> - ubifs
> 
> *: Failed to get the test cases run, thus have to go sandbox mode, and
> attach an image with target fs, load the target file (with unaligned
> range) and compare the result using md5sum.
> 
> For EXT4/FAT, they may need extra cleanup, as their existing unaligned
> range handling is no longer needed anymore, cleaning them up should free
> more code lines than the added one.
> 
> Just not confident enough to modify them all by myself.
> 
> [UNSUPPORTED FSES]
> - Squashfs
>    They don't support non-zero offset, thus it can not handle the tailing
>    block reading.
>    Need extra help to add block aligned offset support.
> 
> - Semihostfs
>    It's using hardcoded trap to do system calls, not sure how it would
>    work for stat() call.

There are no alignment requirements for semihosted FSs. So you can pass in
an unaligned offset and it will work fine. This is because typically the
host will call read() and the host OS will do the aligning.

--Sean
