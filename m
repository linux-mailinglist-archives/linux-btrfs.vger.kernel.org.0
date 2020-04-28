Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C7F1BCC68
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Apr 2020 21:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgD1TbO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Apr 2020 15:31:14 -0400
Received: from smtp-18.italiaonline.it ([213.209.10.18]:48456 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728474AbgD1TbO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Apr 2020 15:31:14 -0400
Received: from venice.bhome ([94.37.199.41])
        by smtp-18.iol.local with ESMTPA
        id TVwkjWzC574wTTVwkjWMpS; Tue, 28 Apr 2020 21:31:11 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1588102272; bh=EaKQkKzf9oUck3J3MKJMqJ/eIEMdHBEVMMyZuP+lb+k=;
        h=From;
        b=GrFXWZwBz5SYyoy1PdrlXNa7CKSw9PkLLLWtdlxOSR+EcHBfLUuHyrRMcZ1WjNaSe
         NfaU4s5KpuNn0Hmi8G0pTrJzwz/hQBUSHhKjf0hIBk9OOiAfi5Wzt6Idt0DWJEqikL
         NBiyv9H9ZrXAVUumthxi6KLIpqN67ewWb6Yb16DsTozNbUVkOaUtJEVgei+qT0DoVm
         sso1DnsLtIawjj6teoueRYL4WQtqEzv0yxOprPEdA5upTAb9te65t3EN5mH5ZKavkG
         lf8t7eU+zMk93N7Ght0AYHwW+IdED5w5RiTpmVuYosfNWtICuPMo+qgYQVDhzjjP9O
         r1ffWhFqxD6Iw==
X-CNFS-Analysis: v=2.3 cv=N5ZX6F1B c=1 sm=1 tr=0
 a=U11oJHogBuzgux+Lqyl0bQ==:117 a=U11oJHogBuzgux+Lqyl0bQ==:17
 a=IkcTkHD0fZMA:10 a=zcrMXTUVjB-az8DntskA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [RFC][PATCH V3] btrfs: ssd_metadata: storing metadata on SSD
To:     Torstein Eide <torsteine@gmail.com>
Cc:     hugo@carfax.org.uk, linux-btrfs@vger.kernel.org,
        martin.svec@zoner.cz, mclaud@roznica.com.ua, wangyugui@e16-tech.com
References: <CAL5DHTHbdXz03XUu2EjadStDWTMBsyawTnkbnXhgN=hAXMFN2w@mail.gmail.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <935f0a14-a47f-4edf-4b29-63e078148457@libero.it>
Date:   Tue, 28 Apr 2020 21:31:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAL5DHTHbdXz03XUu2EjadStDWTMBsyawTnkbnXhgN=hAXMFN2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfK6Udz9oK1f43n6GP8Th6mdQbKlC97nOlFScekb0OnND3rJp1TSqpGYKqsCevovLd8U2s835MzPR3oO9E8D/cx+T6OSjDjp74e4AUSgkInQ1umPVv8iJ
 68dXRiZcj/zpKcQywBn+WOMDR1ycDlBHR3Ie4zQxX7vYg20hGflDkeVjUWKnfB1vtT0BbhwZbykVPTRWjtHJMzAY14RVAcnEzpqPQ8lLmY/EL9QbAC5gdOcv
 WHUr2bBRdf+e8K/AByzl2fvZek86bN28+vys2w/g8wgNbMAzs4E6847JGLwd4DDmUnW6jMF3ogdyB4y+/1JkGdAU85buk5k7SqVp5OgpKk0=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/27/20 5:06 PM, Torstein Eide wrote:
> How will affect sleep of disk? will it reduce the number of wake up
> call, to the HDD?
No; this patch put the metadata on the SSD, leaving data in the HDD;
this means that if you add data to a file both the HDD and the SSD will be used.
  
BR
G.Baroncelli

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
