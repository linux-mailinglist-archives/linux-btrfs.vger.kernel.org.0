Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA488221A5
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 May 2019 06:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbfEREj6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 May 2019 00:39:58 -0400
Received: from resqmta-ch2-01v.sys.comcast.net ([69.252.207.33]:58200 "EHLO
        resqmta-ch2-01v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725268AbfEREj6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 May 2019 00:39:58 -0400
Received: from resomta-ch2-20v.sys.comcast.net ([69.252.207.116])
        by resqmta-ch2-01v.sys.comcast.net with ESMTP
        id Rr7VhaZ3kLJtxRr8XhkRlB; Sat, 18 May 2019 04:39:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20180828_2048; t=1558154397;
        bh=KzeI4xHXXeuf7MKA0OEzusIO3o946CnbG/iEQk+87Ek=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=iFiATA791xSqivAWgA83vf+5Zc/ah0xMAUdmVKYjrpSsG17Amaas4k5NWcWffGQ4I
         54Klf/gNs9jZYIoVjyu5MCjLAYZkKLY7DREKOWIqIvM9HYHBQhdvJakXyEfaXqZg1h
         dKhNeQ/INouwFApt5aUsrmE4icqprSpyXzObrfzMmaAuGLK8jsFkI1j3sXtDgCYFa6
         2J9DI0bjialvB+oROV6PreD5GlU0pP+F/EhIaFtZzbStsybTmJvJTQ/0p9I1sXOj/q
         KRwU5ffh2gEcB7QiF+goUMzppahvs8kECM5jRqGnAJTzZggHEP6f0cytFlD/wyeCvV
         JFhxwtW5/GuRw==
Received: from touchy.whiterc.com ([IPv6:2601:601:1400:69b3:5588:da99:221d:2c69])
        by resomta-ch2-20v.sys.comcast.net with ESMTPSA
        id Rr8Vhp5nE5DQoRr8Whr4cC; Sat, 18 May 2019 04:39:57 +0000
X-Xfinity-VMeta: sc=-100;st=legit
Subject: Re: Unbootable root btrfs
To:     Chris Murphy <lists@colorremedies.com>,
        Lee Fleming <leeflemingster@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAKS=YrP=z2+rP5AtFKkf7epi+Dr2Arfsaq3pZ9cR3iKif3gV5g@mail.gmail.com>
 <CAJCQCtTmZY-UHeNYp=waTV8TWiAKXr8bJq13DQ7KQg=syvQ=tg@mail.gmail.com>
 <CAKS=YrMB6SNbCnJsU=rD5gC6cR5yEnSzPDax5eP-VQ-UpzHvAg@mail.gmail.com>
 <CAJCQCtQhrh8VBKe11gQUt5BSuWCsDQUdt_Q4a4opnAYE5XoEVQ@mail.gmail.com>
From:   Robert White <rwhite@pobox.com>
Message-ID: <2571b502-737b-05b5-633b-cf198c0e6764@pobox.com>
Date:   Sat, 18 May 2019 04:39:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQhrh8VBKe11gQUt5BSuWCsDQUdt_Q4a4opnAYE5XoEVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/18/19 4:06 AM, Chris Murphy wrote:
> On Fri, May 17, 2019 at 2:18 AM Lee Fleming <leeflemingster@gmail.com> wrote:
>>
>> I didn't see that particular warning. I did see a warning that it could cause damage and should be tried after trying some other things which I did. The data on this drive isn't important. I just wanted to see if it could be recovered before reinstalling.
>>
>> There was no crash, just a reboot. I was setting up KVM and I rebooted into a different kernel to see if some performance problems were kernel related. And it just didn't boot.
> 
> OK the corrupted Btrfs volume is a guest file system?

Was the reboot a reboot of the guest instance or the host? The reboot of 
the host can be indistinguishable from a crash to the guest file system 
images if shutdown is taking a long time. That megear fifteen second gap 
between SIGTERM and SIGKILL can be a real VM killer even in an orderly 
shutdown. If you don't have a qemu shutdown script in your host 
environment then every orderly shutdown is a risk to any running VM.

The question that comes to my mind is to ask what -blockdev and/or 
-drive parameters you are using? Some of the combinations of features 
and flags can, in the name of speed, "helpfully violate" the necessary 
I/O orderings that filesystems depend on.

So if the crash kills qemu before qemu has flushed and completed a 
guest-system-critical write to the host store you've suffered a 
corruption that has nothing to do with the filesystem code base.

So, for example, you shutdown your host system. I sends SIGTERM to qemu. 
The guest system sends SIGTERM to its processes. The guest is still 
waiting its nominal 15 seconds, when the host evicts it from memory with 
a SIGKILL because it's 15 second timer started sooner.

(15 seconds is the canonical time from my UNIX days, I don't know what 
the real times are for every distribution.)

Upping the caching behaviours for writes can be just as deadly in some 
conditions.

None of this my apply to OP, but it's the thing I'd check before before 
digging too far.
