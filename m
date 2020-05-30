Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5A91E90ED
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 May 2020 13:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgE3Lv6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 May 2020 07:51:58 -0400
Received: from smtp-34.italiaonline.it ([213.209.10.34]:48385 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728433AbgE3Lv6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 May 2020 07:51:58 -0400
Received: from venice.bhome ([78.12.136.199])
        by smtp-34.iol.local with ESMTPA
        id f01pj2MpZtrlwf01pjWJD8; Sat, 30 May 2020 13:51:56 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1590839516; bh=Ts74NG8F7TEB7vWE5XzghOU/r9uZLpNX9PE1Qe/6bQs=;
        h=From;
        b=mWVufS19C8Q82OJ6d8YHO3vWJ5HjbujdTgcBQmv95DKQGpZ3r8o4XB3/84wLulSlW
         HKFKdLpp2pSZ+2QgSA1vo+Ngdi5tguDHKlPHkKzHsJ0TUwzoPPBxWSlF2dTuSIKpjE
         Zfaq5jCgnuZYJ8B7k5XqwXs6Q6gDbOcK/8ScEogkK+M+xfdJ8a+1DjeNap/oiTcsjP
         11yfvRTzBdF9ZYrYoURCtcn4oGXEolxwshwegNxRjtZxPGJXh+kydDWLb0xiue/dsl
         Hc4JAPxVvlojpOgG1vPlwqV0wf6L1zbdITFralB1447cnRrKOvvZr7c6OTi+l619lr
         hOnJ7Rl4J4fKQ==
X-CNFS-Analysis: v=2.3 cv=TOE7tGta c=1 sm=1 tr=0
 a=kx39m2EDZI1V9vDwKCQCcA==:117 a=kx39m2EDZI1V9vDwKCQCcA==:17
 a=IkcTkHD0fZMA:10 a=2-IjpnIz8VEHN9WGJEUA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [RFC][PATCH V4] btrfs: preferred_metadata: preferred device for
 metadata
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Hans van Kranenburg <hans@knorrie.org>,
        linux-btrfs@vger.kernel.org, Michael <mclaud@roznica.com.ua>,
        Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Paul Jones <paul@pauljones.id.au>,
        Adam Borowski <kilobyte@angband.pl>
References: <20200528183451.16654-1-kreijack@libero.it>
 <8f85f920-b0d0-3c11-3fd2-2f831efb37f4@knorrie.org>
 <f1982b10-2b02-5a6c-a613-c961de4fa6db@libero.it>
 <20200530114431.GG10769@hungrycats.org>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <035d901c-ba44-565e-3305-8999942c5d5d@inwind.it>
Date:   Sat, 30 May 2020 13:51:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200530114431.GG10769@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIDbEy805oongP23NY5JxnAniQPqQUmUWsg6Wdmr2c1400+ePf42K0XA4Q2J+Z7bHu4BhLxcEJ8c89OzOmbKKGmOkgH1yYVQOQdN5G2/iprYE3ozDjF2
 1Xs3aNeIiL60dsVg2uEnhkw2hBGqxuTJQHtv6W+ayrL4771KvWlx+RPj8pzUVzSFhG5XeMQdDbK0XRZocFeeSfXu2vGwR5p/2d8wryhUovZgsXVMeUBKXMlP
 2lUuY7G7qXazsyNEwvs4+PNuZ8nX9QJRQvmGMRbHoqXnBJhcV2f/5R2VwQvSdxCy28jZDNYrYljCEOI4ZpIBkc/m50mwCDLh3gLqz3fA3cUNnZIJ88IroGEr
 Gw4pR3DD9ND7PRgep1TOGTXh+f8LxdMQQUlg1MiE5t4VwG+egu6eLYD4dK2aV55QyJlMMImT7Wfvbgjyzf6T60v2aFmgBQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/30/20 1:44 PM, Zygo Blaxell wrote:
> On Fri, May 29, 2020 at 06:37:27PM +0200, Goffredo Baroncelli wrote:
>> On 5/28/20 11:59 PM, Hans van Kranenbu

[...]
>>> What are your thoughts about the chicken/egg situation of changing these
>>> properties only when the filesystem is mounted?
>>
>> The logic is related only to a chunk allocation. I.e. if you have a not
>> empty filesystem, after enabling the preferred_metadata "mode", in order
>> to get the benefit a full balance is required.
> 
> Ideally this feature comes with a balance filter that selects block
> groups that don't match the current preferred allocation policy, so
> you can do a balance on those block groups and leave the rest alone.
> There are existing balance filters by devid and stripe count to work from,
> so it shouldn't be a lot of new kernel code.
> 
Yes, this could be a further enhancement.

GB

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
