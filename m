Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B221C1BE3F
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2019 21:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbfEMT5u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 May 2019 15:57:50 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:49762 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfEMT5t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 May 2019 15:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dirtcellar.net; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To; bh=hoXukvvj8Sd45+gMAVc4vgYV2bOYgMY0J74i2N4oE9A=;
        b=FREoMO4y0bRwaWkxzGeS1Ukmrh/ZQLaSQKUCLBMDyl1rts56ipFXl6uAa/+4cnet+03x2BqvrnQ/PGlDQ55K0aCEcBzDIKldRLdc/jvaATir2lHSfzxpL3yR13w0KywzSE6c7cENT2Hydo10WHWc5QXDH3rjrvXhf0LEhwMYlcqxLMDZk7Y3TAT8wp5B9AgFthpwvY/Jv2MaXvj0B5rYlHz/4ok17GMqharF1r508FBk1vA+apDLOeYeLR9+O3kgEo8cVwPDkK1iWLuffaT9D+RXXdLwwV48dYIR7PF93xIZmAtAmuJmbb1yVwXxcvt8r2AaMICd1uZ0WrH/BAcZSw==;
Received: from 73.79-160-166.customer.lyse.net ([79.160.166.73]:13105 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1hQH50-0003I3-IE; Mon, 13 May 2019 21:57:46 +0200
Reply-To: waxhead@dirtcellar.net
Subject: Re: [PATCH V9] Btrfs: enhance raid1/10 balance heuristic
To:     dsterba@suse.cz, Timofey Titovets <timofey.titovets@synesis.ru>,
        linux-btrfs@vger.kernel.org,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Dmitrii Tcvetkov <demfloro@demfloro.ru>
References: <20190506143740.26614-1-timofey.titovets@synesis.ru>
 <20190513185250.GJ3138@twin.jikos.cz>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <574d214e-0c9c-0f93-1078-d07d183554dd@dirtcellar.net>
Date:   Mon, 13 May 2019 21:57:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <20190513185250.GJ3138@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

David Sterba wrote:
> On Mon, May 06, 2019 at 05:37:40PM +0300, Timofey Titovets wrote:
>> From: Timofey Titovets <nefelim4ag@gmail.com>
>>
>> Currently btrfs raid1/10 bаlance requests to mirrors,
>> based on pid % num of mirrors.
>>
> 
> Regarding the patches to select mirror policy, that Anand sent, I think
> we first should provide a sane default policy that addresses most
> commong workloads before we offer an interface for users that see the
> need to fiddle with it.
> 
As just a regular btrfs user I would just like to add that I earlier 
made a comment where I think that btrfs should have the ability to 
assign certain DevID's to groups (storage device groups).

 From there I think it would be a good idea to "assign" subvolumes to 
either one (or more) group(s) so that btrfs would prefer (if free space 
permits) to store data from that subvolume on a certain group of storage 
devices.

If you could also set a weight value for read and write separately for a 
group then you are from a humble users point of view good to go and any 
PID% optimization (and management) while very interesting sounds less 
important.

As BTRFS scales to more than 32 devices (I think there is a limit for 30 
or 32????) device groups should really be in there from a management 
point of view and mount options for readmirror policy does not sound 
good the way I understand it as this would affect the fileystem globally.

Groups could also allow for useful features like making sure metadata 
stays on fast devices, migrating hot data to faster groups automatically 
on read, and when (if?) subvolumes support different storage profiles 
"Raid1/10/5/6" it sounds like an even better idea to assign such 
subvolumes to faster/slower groups depending on the storage profile.

Anyway... I just felt like airing some ideas since the readmirror topic 
has come up a few times on the mailing list recently.
