Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C121534134
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 May 2022 18:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbiEYQQb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 May 2022 12:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbiEYQQ3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 May 2022 12:16:29 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 May 2022 09:16:26 PDT
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3FA6B09D
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 09:16:26 -0700 (PDT)
Received: from [192.168.1.27] ([78.12.14.90])
        by smtp-16.iol.local with ESMTPA
        id ttfNnSv91ajntttfOnrEt1; Wed, 25 May 2022 18:15:22 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1653495322; bh=MxwAZ/EMw5BibBktb63pxaiwa0MHDkKEMEsiyifo9Ig=;
        h=From;
        b=W5gJFIBusTuQ9bUd/ah2AK2P4hkD4HKQIG4xxHKa0u3rFYh9xLrHNMYdQMY7qWAA6
         0PyBpJCoH175ic5usJeJWI+p4N45ZedwH73l+sR/679ZDkwo0StwQrgSd3qWt3S8pG
         LTnfFQKcvAk/0UzJnqdGBb5yfQs2mb/Wioa03Ml1NOPzq/qGEgFaT6xEPHh/3i//NE
         c7kogA6nQ4m/MUemAaPWTVOPRiqFIBiC2hsn5ru14snxjmdbw42/3k5lwhtfrChqOG
         5ayVyeKJq21edxX0xCdhscDKdJUQoBzb72oka0IgX1QTCMhtyJD99EqYrIiEMEBO4d
         Ds5xOVnHbOcUw==
X-CNFS-Analysis: v=2.4 cv=Uvqmi88B c=1 sm=1 tr=0 ts=628e561a cx=a_exe
 a=tzWkov1jpxwUGlXVT4HyzQ==:117 a=tzWkov1jpxwUGlXVT4HyzQ==:17
 a=IkcTkHD0fZMA:10 a=MUaiHojgB2rHEMeO-RAA:9 a=QEXdDO2ut3YA:10
Message-ID: <13c16692-9027-cfba-52b5-9993e10b0d20@inwind.it>
Date:   Wed, 25 May 2022 18:15:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Reply-To: kreijack@inwind.it
Subject: Re: cp --reflink and NOCOW files
Content-Language: en-US
To:     Forza <forza@tnonline.net>,
        Matthew Warren <matthewwarren101010@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <c6f55508-a0df-aea3-279d-75648793dfb2@libero.it>
 <CA+H1V9zNSiJgXj6w8i2syhm_4qeaxkYPZHuxLgjmfP-jjGMYBQ@mail.gmail.com>
 <1e7afa05-3510-25c4-43d5-f1a6678ddcf8@tnonline.net>
From:   Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <1e7afa05-3510-25c4-43d5-f1a6678ddcf8@tnonline.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfH2H6pk79yayo9hOeu6opaFrCzw3BJLjmkgiDAfPqJ2k2KJuKRKXYSlDq7Axm7wdpfNJRjv7QVi5XQ/k1b9Uifp4GTmXCiStyzfcFvNCRFdH1NUVDNwh
 0DIH9Tpy2QqxZOYOB0pJKwywBdUXGWWcWT3FhoFPhe6wviWwZL5kTIOB3+2lifb+bZ4wlTq1Rr/L95s5hqEmFxZhjcS3fP3bh18BjEI++wc86IxTFYpcfSXQ
 UBGOc60a041kgMTbL+j6ppsfKRkjiNHttl0/IITPYiE=
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 25/05/2022 06.34, Forza wrote:
>  > You can only reflink files which are COW. If you want to reflink files
>  > which are NOCOW, you have to copy them to a COW file (eg. cp
>  > file-very-big-nocow file-very-big-cow) and then you can reflink it.
>  > It's recommended to keep everything COW unless it has many random
>  > writes like databases and virtual machines.
>  >
>  > Matthew Warren
> 
> The problem is with coreutils and 'cp', not Btrfs. It is possible to reflink copy nodatacow files. The requirement is that the target is also nodatacow. Deduplication of nodatacow files has the same limitation as well.
> 

Correct. More in another thread.

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
