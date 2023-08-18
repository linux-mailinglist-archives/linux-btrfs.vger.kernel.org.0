Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DD4781364
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Aug 2023 21:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355677AbjHRTg7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Aug 2023 15:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379628AbjHRTgZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Aug 2023 15:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5155E421C
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Aug 2023 12:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692387342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BrQdf0GkcvOQID6YKUNm9kecc+hMz7+NpVKlR9WNpyY=;
        b=OKlex2kpbuArKdwigniNFzT1TBYetfJbaxtsAL2NnL1bUdlO27R2Ba+cRlzkkup9sF/Zij
        TATBWV7uK4+QN/qgUE4Suy4zFytOiuMWAZVnVyr2v63gSvxytg86JWrh9NgcXUQ+R1lHqJ
        TNzaozY5aooaSFppwgmG5pbCnsKfEB4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-zFpD20WZNhqLYdGFhek8LA-1; Fri, 18 Aug 2023 15:35:38 -0400
X-MC-Unique: zFpD20WZNhqLYdGFhek8LA-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1bde50b4dc5so17454225ad.3
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Aug 2023 12:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692387337; x=1692992137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrQdf0GkcvOQID6YKUNm9kecc+hMz7+NpVKlR9WNpyY=;
        b=Nx3ukBskWHwydB53v3P7MU/3AZpe3hK9F8Qt0wwy43eQszI5fL60qu9yCOL9bLA71w
         iLTdPV936YqFZwfkxxHxboJ2yU8YRVoiF8ki8U8KKk13dPgtevwJyVOCWYN5DJWvkwk7
         7O1190lzW4JWTS/yxgM5RkwirmtlIMX3skvvBAK+q4Z//tGZUhCBaKGq2Onme4rz/Xh/
         u5CTVgcwt8jHVehVCmUl0r39B1HC55qX5SDG6+Ynu5A5ccJmKwiS+e0XoMAUyaBRENy8
         4Z4stwxz/q9WuZVr6vMRv36SddIBFyuvz0/8TPcQUL0pQzgiXW0UbVxXT7AXksLricRz
         eD9A==
X-Gm-Message-State: AOJu0YyQoUAuMFFssA/qh8wYxcph8zEt8vM7tO5ksY0lc3EUBF3p1hp+
        COFykLSytmTr83m7QPB2xDxigoLR7L4r8mhSYYhpjASrWTqg0UFa3x+QpDc/an6iiuQqH1bSDCL
        xL35ioZD4v/kydUdh5D5DDzc=
X-Received: by 2002:a17:903:18e:b0:1bb:891b:8bd with SMTP id z14-20020a170903018e00b001bb891b08bdmr172615plg.34.1692387337453;
        Fri, 18 Aug 2023 12:35:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA36BB1TWknTxgkbMpIEzudrc5rf5DN8F7lY/3KPMSD1q5dqE5Pp+DkZHRKhI3BDEAXQDokQ==
X-Received: by 2002:a17:903:18e:b0:1bb:891b:8bd with SMTP id z14-20020a170903018e00b001bb891b08bdmr172596plg.34.1692387337134;
        Fri, 18 Aug 2023 12:35:37 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id kx14-20020a170902f94e00b001b567bbe82dsm2126412plb.150.2023.08.18.12.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 12:35:36 -0700 (PDT)
Date:   Sat, 19 Aug 2023 03:35:33 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs/179: optimize remove file selection
Message-ID: <20230818193533.kuonbvwzvuw7eflw@zlang-mailbox>
References: <20230817051317.3825299-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817051317.3825299-1-naohiro.aota@wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 17, 2023 at 02:13:17PM +0900, Naohiro Aota wrote:
> Currently, we use "ls ... | sort -R | head -n1" to choose a removing
> victim. It sorts the files with "ls", sort it randomly and pick the first
> line, which wastes the "ls" sort.
> 
> Also, using "sort -R | head -n1" is inefficient. For example, in a
> directory with 1000000 files, it takes more than 15 seconds to pick a file.
> 
>   $ time bash -c "ls -U | sort -R | head -n 1 >/dev/null"
>   bash -c "ls -U | sort -R | head -n 1 >/dev/null"  15.38s user 0.14s system 99% cpu 15.536 total
> 
>   $ time bash -c "ls -U | shuf -n 1 >/dev/null"
>   bash -c "ls -U | shuf -n 1 >/dev/null"  0.30s user 0.12s system 138% cpu 0.306 total
> 
> So, just use "ls -U" and "shuf -n 1" to choose a victim.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  tests/btrfs/179 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/179 b/tests/btrfs/179
> index 2f17c9f9fb4a..0fbd875cf01b 100755
> --- a/tests/btrfs/179
> +++ b/tests/btrfs/179
> @@ -45,7 +45,7 @@ fill_workload()
>  
>  		# Randomly remove some files for every 5 loop
>  		if [ $(( $i % 5 )) -eq 0 ]; then
> -			victim=$(ls "$SCRATCH_MNT/src" | sort -R | head -n1)
> +			victim=$(ls -U "$SCRATCH_MNT/src" | shuf -n 1)

Thanks for this improvement. This case has two lines have this similar logic,
Why not change them both?

And btrfs/192 has a similar line too:

$ grep -rsn -- "sort -R" tests
tests/btrfs/179:48:                     victim=$(ls "$SCRATCH_MNT/src" | sort -R | head -n1)
tests/btrfs/179:72:             victim=$(ls "$SCRATCH_MNT/snapshots" | sort -R | head -n1)
tests/btrfs/192:75:     echo "$basedir/$(ls $basedir | sort -R | tail -1)"
tests/btrfs/004:204:    for file in `find $dir -name f\* -size +0 | sort -R`; do

Do we need to change that too? And a common helper might help, if more cases
would like to have this helper?

Thanks,
Zorro

>  			rm "$SCRATCH_MNT/src/$victim"
>  		fi
>  		i=$((i + 1))
> -- 
> 2.41.0
> 

