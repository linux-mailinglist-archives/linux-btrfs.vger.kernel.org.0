Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCF17997BB
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Sep 2023 13:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240463AbjIILw2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Sep 2023 07:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjIILw1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 Sep 2023 07:52:27 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320CFE46
        for <linux-btrfs@vger.kernel.org>; Sat,  9 Sep 2023 04:52:23 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-403012f27e1so5995785e9.1
        for <linux-btrfs@vger.kernel.org>; Sat, 09 Sep 2023 04:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foutras.com; s=google; t=1694260341; x=1694865141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ceXFPTd5Eujh7uxkGHXpJ4Jhvs/GHiLRkck03RO73wk=;
        b=Mrr/y29CNO5YcPQSbq+d1nqPDt86os4knor3pZCsaA//LWVDzyp1earT4edJS+mW8+
         ze9TkXDBTqjZQSV55HMtnKW20JJuOs0BPwDmIIb26zjirVCsQ9HbOQG/BnHMLCpv5U7d
         ZbO20MntcnhDmD5xOG9Jrjrd0iAPeuteFIV7Fvupat60gmm1J2zIJ+qTgrpp8qeUnDtG
         mK/Mxens4OFlN4aJzhQ8o18rG8TdJz2SpJ9RCsvZNfo4Ty7kUx5Nu0ilIIKN4y4REp0v
         b+u1fLkcuOGnej0RRMSsfJAaqcxNscPKr981H0KDy9AGRl3RvqCPEgPVXE9EemfzZj8E
         smhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694260341; x=1694865141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ceXFPTd5Eujh7uxkGHXpJ4Jhvs/GHiLRkck03RO73wk=;
        b=Xacmvqy1cG/CzPK4Z6KSn3Uqcf08ozdlx0p7kJzNRLZ/S9xVZN3BawUCklYq+WASlk
         iYG1/5+0PbzaXMFtH5MpHYXYzLV8LVdWRVnTBpnTx4ckPzcHHKtl5eZtmNnsQAlghFcV
         9LO5taEceggAcsZgBLFFTIIWmuUrsaZlllyGBuxWPvNCWdg6EfJ8gZAzngP/2A+NIWjZ
         LjfFzu86jGG9UWdBx87zxjoyKqzAiv8ObyFtbrTrrgSqttHL7pEn8eSzqvuIXE5k5+Kb
         KyPGv/1R9HbtOLylMWGi6efA8IErL7eDOqKg596lubluO4C5NZuI0vxfc5MVgVYzrgzE
         zLjA==
X-Gm-Message-State: AOJu0Yw8LVmzVNiDmsT766hSxawCbGE+4//K6cXD8MIYgsP2TBbr/zMx
        hA6Xn72NCI1xx2HrIjS+Klr9Hr61VR3uJsT9uU87EsRb
X-Google-Smtp-Source: AGHT+IEOyMWyGYqrmJ171U/HjAyKqVCTXhn9VSj+XXsG/bWYA4K7sQkXo4ZlEqPCxiK2fZZEsKA7qQ==
X-Received: by 2002:a7b:cb90:0:b0:3fe:dc99:56ea with SMTP id m16-20020a7bcb90000000b003fedc9956eamr4103003wmi.19.1694260341578;
        Sat, 09 Sep 2023 04:52:21 -0700 (PDT)
Received: from ?IPV6:2a02:587:e809:2c00:7c0a:57b5:562b:df86? ([2a02:587:e809:2c00:7c0a:57b5:562b:df86])
        by smtp.gmail.com with ESMTPSA id l10-20020a1c790a000000b003fed70fb09dsm4443411wme.26.2023.09.09.04.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 04:52:21 -0700 (PDT)
Message-ID: <00ed09b9-d60c-4605-b3b6-f4e79bf92fca@foutras.com>
Date:   Sat, 9 Sep 2023 14:52:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible readdir regression with BTRFS
To:     Filipe Manana <fdmanana@kernel.org>,
        Ian Johnson <ian@ianjohnson.dev>
Cc:     linux-btrfs@vger.kernel.org
References: <YR1P0S.NGASEG570GJ8@ianjohnson.dev>
 <ZPweR/773V2lmf0I@debian0.Home>
Content-Language: en-US
From:   Evangelos Foutras <evangelos@foutras.com>
In-Reply-To: <ZPweR/773V2lmf0I@debian0.Home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Filipe,

Please be aware that this bug might not be as harmless as it seems. I'm 
not sure if the fix you're preparing would also fix an issue we saw at 
Arch Linux but I thought I'd mention it here.

We have a package repository server with 4x10 TB drives in RAID10 (btrfs 
only, no mdadm). On multiple mirrors syncing from it we have seen rsync 
occasionally delete ~4 small (<10 MB) files that get frequently updated 
by renaming temporary files into them. This only happened with 6.4.12 
and went away after going back to 6.4.10 (the former had the commit Ian 
mentioned).

Unfortunately I don't have a reproducer for this. I can only describe 
what our repo-add script does and how rsync behaves during problematic 
syncs.

Our repo-add script frequently adds packages to the extra repo by doing:

   ln -f extra.db.tar.gz extra.db.tar.gz.old
   mv .tmp.extra.db.tar.gz extra.db.tar.gz

And the same for extra.files.tar.gz:

   ln -f extra.files.tar.gz extra.files.tar.gz.old
   mv .tmp.extra.files.tar.gz extra.files.tar.gz

While the server was running Linux 6.4.12, rsync on some mirrors would 
occasionally (3-4 times in the day) delete these files:

   deleting extra/os/x86_64/extra.files.tar.gz.old
   deleting extra/os/x86_64/extra.files.tar.gz
   deleting extra/os/x86_64/extra.db.tar.gz.old
   deleting extra/os/x86_64/extra.db.tar.gz

Since renames are atomic, I would expect this scenario to never happen.

Again, sorry for not being able to provide a proper reproducer like Ian; 
there is probably some timing interaction with how rsync does directory 
scanning and repo-add updating the directory entry during this time.

[1] 
https://gitlab.archlinux.org/pacman/pacman/-/blob/v6.0.2/scripts/repo-add.sh.in#L473
