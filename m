Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835C9323029
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Feb 2021 19:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhBWSCQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Feb 2021 13:02:16 -0500
Received: from smtp-35.italiaonline.it ([213.209.10.35]:57402 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233011AbhBWSCP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Feb 2021 13:02:15 -0500
Received: from venice.bhome ([78.12.28.43])
        by smtp-35.iol.local with ESMTPA
        id Ec05l4CftpK9wEc05lsb8o; Tue, 23 Feb 2021 19:01:33 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1614103293; bh=4c/9yfqrXJk4VFyFWBcxoAZ83ynBPf+FlEXSW3RwtAs=;
        h=From;
        b=hl1g9lO4quLN6uSMypKZM2hnpi6389j0G68x0475eWjXCMKKJ97TOQe2DVYwHnX/E
         5TbUAHjed1qxMuUBNC/enalzjXV1DJ11lf4vzbgfj5YWTJHbEyZQ3W/E8JeSNKXwsa
         xBd5gokIg9XAMC8TYC+/ArAbcO4rdxaK5uZI9nypINY6/VyBf2Eekqs/QD6ul0Het/
         +agn3Z0sTsP2/3ANIQHOHA1A94PGhO/wbOKZd7yJ614RurTnfUiJ55f4hkgV7x0QtT
         EXffJdQFr0/KK2BzmgsGeLuY0fW/wfzNIixwK4wEY7zEDCFMEllczD+8MGBOgoSTQH
         DeOKpqY/HR+tQ==
X-CNFS-Analysis: v=2.4 cv=A9ipg4aG c=1 sm=1 tr=0 ts=603542fd cx=a_exe
 a=Q5/16X4GlyvtzKxRBiE+Uw==:117 a=Q5/16X4GlyvtzKxRBiE+Uw==:17
 a=IkcTkHD0fZMA:10 a=JDK0MQmMijRVaaqq_vgA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 1/4] btrfs: add ioctl BTRFS_IOC_DEV_PROPERTIES.
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <cover.1614028083.git.kreijack@inwind.it>
 <d48a0e28d4ba516602297437b1f132f2a8efd5d2.1614028083.git.kreijack@inwind.it>
 <20210223135330.GU1993@twin.jikos.cz>
 <73fa4d2c-2593-5db2-c9b2-3adb34fb51b4@libero.it>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <11613dcb-2819-5a64-773a-355eb110cd54@inwind.it>
Date:   Tue, 23 Feb 2021 19:01:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <73fa4d2c-2593-5db2-c9b2-3adb34fb51b4@libero.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfGQ2n+qlPT0Ne2O977ukTtYvmvHhwPoqeliduv6qXhuJXrCpnrn7SNYQ1FYgdu4y3I0L0eXrzGXDi8h5yx23UHy6IKC2iPsWqFh5bfpHzMuy3nzSDn4b
 vJ4yJXE9DuGzjzd3eqDE9uWSjRucPTdfKRXMNvhj+XrJEQOEaXMNYIeAmeqz2WujCxZH+Vab2zcUSoVMMZDyMOmUWTOKCi74WAA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I resend it because I made a little mess with the quotation

On 2/23/21 6:59 PM, Goffredo Baroncelli wrote:
> On 2/23/21 2:53 PM, David Sterba wrote:
>> On Mon, Feb 22, 2021 at 10:19:06PM +0100, Goffredo Baroncelli wrote:
>>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>>
>>> This ioctl is a base for returning / setting information from / to  the
>>> fields of the btrfs_dev_item object.
> 

Hi David,

> 
>>
>> Please don't add a new ioctl for properties, they're using the xattr as
>> interface alrady.

How it is supposed to work with a device ?
  
I have to point out that the property is already exported in sysfs.
However I read a comment in sysfs code that discourages
to make a filesystem updating (open a new transaction) in the sysfs
handler. Do you have any suggestion ?



> 
> Thanks in advance
> BR
> Goffredo
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
