Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A56517E993
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2020 21:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgCIUBX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 16:01:23 -0400
Received: from mailfilter01-out31.webhostingserver.nl ([141.138.168.60]:61431
        "EHLO mailfilter01-out31.webhostingserver.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725992AbgCIUBW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Mar 2020 16:01:22 -0400
X-Greylist: delayed 961 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Mar 2020 16:01:21 EDT
X-Halon-ID: 803cd193-623e-11ea-97d2-001a4a4cb906
Received: from s198.webhostingserver.nl (s198.webhostingserver.nl [141.138.168.154])
        by mailfilter01.webhostingserver.nl (Halon) with ESMTPSA
        id 803cd193-623e-11ea-97d2-001a4a4cb906;
        Mon, 09 Mar 2020 20:45:16 +0100 (CET)
Received: from cust-178-250-146-69.breedbanddelft.nl ([178.250.146.69] helo=[10.8.0.10])
        by s198.webhostingserver.nl with esmtpa (Exim 4.92.3)
        (envelope-from <fntoth@gmail.com>)
        id 1jBOKy-002hN6-Ji; Mon, 09 Mar 2020 20:45:16 +0100
Subject: Re: problem with newer kernels
To:     Arun Persaud <apersaud@lbl.gov>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <e8904a49-bd28-46c7-77d0-d114627ce0d9@lbl.gov>
 <CAJCQCtT0CVBfupwj9wM3JAopg7YZ3FicLFGMo=is21CdyEg8Jg@mail.gmail.com>
 <aa4ba5af-1d0f-9db2-8cad-693b970bf843@lbl.gov>
 <dd0dffb5-e248-4498-dffb-4a6e6e4fd0fb@gmx.com>
 <99ddd844-3371-d496-701d-bc6ea9fb0779@lbl.gov>
 <dd7f7fb0-a0da-cc8b-8af6-3b9c3bc2878a@gmx.com>
 <07ec54b8-207e-93f2-58e8-4f096ea96e98@lbl.gov>
From:   Ferry Toth <fntoth@gmail.com>
Message-ID: <9bf4fdb5-5909-d7d1-2019-5c2c671ace18@gmail.com>
Date:   Mon, 9 Mar 2020 20:45:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <07ec54b8-207e-93f2-58e8-4f096ea96e98@lbl.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SendingUser: hidden
X-SendingServer: hidden
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Authenticated-Id: hidden
X-SendingUser: hidden
X-SendingServer: hidden
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Op 09-03-2020 om 17:39 schreef Arun Persaud:
> Hi
> 
>> [...]
>> That's strange.
>> As btrfs check selftest can detect such inode generation mismatch and
>> repair it.
>>
>> If btrfs-progs failed to repair it, you can delete that inode manually
>> using older kernel.

We had similar problems, but many files with invalid creation date. As 
it was our boot partition we could only fix using old kernel to boot and 
recreating the files.

https://lore.kernel.org/linux-btrfs/36d45e31-f125-4b21-a68e-428f807180f7@gmail.com/

>> `find -inum 131072` can locate that inode.
> 
> not sure how to delete it afterwards...
> 
>> But before you delete it, please provide the following dump for us to
>> further debug the problem.
>>
>> # btrfs ins dump-tree -b 14720090112 /dev/sda2
> 
> sure, I can also wait a bit longer before fixing this, since I can at
> the moment always boot the old kernel.
> 
> I ran the command using the old kernel (since I had that one booted). I
> then rebooted into the emergency system of the new kernel and ran again.
> Afterwards I went back to the working system (old kernel). Output is
> attached. First and second run gave the same output, the third run gave
> a lot less output?!
> 
>> Please note that, the dump will contain filenames, feel free to remove
>> such filenames.
> 
> I didn't see any file names in the output...
> 
> HTH
> 
> Arun
> 

