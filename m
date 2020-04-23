Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747881B5855
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Apr 2020 11:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgDWJjb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Apr 2020 05:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgDWJjb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Apr 2020 05:39:31 -0400
Received: from wp558.webpack.hosteurope.de (wp558.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8250::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD55C03C1AF
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Apr 2020 02:39:31 -0700 (PDT)
Received: from mail1.i-concept.de ([130.180.70.237] helo=[192.168.122.235]); authenticated
        by wp558.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1jRYKP-0007nu-KW; Thu, 23 Apr 2020 11:39:29 +0200
Subject: Re: Recommended Partitioning & Subvolume Layout | Newbie Question
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <03fdc397-4fca-335f-03d8-f93a96d92105@peter-speer.de>
 <CAJCQCtTnA6Dro2XwEm0S7ohUnf_CMGb7giHsBfh4_KtWE4vR6g@mail.gmail.com>
From:   Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Message-ID: <7019baf9-5064-4d16-a09a-5dc5672672de@peter-speer.de>
Date:   Thu, 23 Apr 2020 11:39:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTnA6Dro2XwEm0S7ohUnf_CMGb7giHsBfh4_KtWE4vR6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;stefanie.leisestreichler@peter-speer.de;1587634771;ebc7d34b;
X-HE-SMSGID: 1jRYKP-0007nu-KW
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22.04.20 23:03, Chris Murphy wrote:
> What's the gotcha? Well, my /var has been rolled back, and also the
> systemd journal. OK so I could make /var/lib/libvirt and /var/log
> subvolumes so they don't get snapshot and rolled back. What I tend to
> do is put those in the top level of the file system, and have fstab
> entries to mount them to the proper location during startup, that way
> I don't have to worry about manually fixing things on a rollback.

Thanks for your time and answer.

I tend to lean on the fedora layout as far as my limited knowledge 
allows to calculate the impacts so far :-(

I do not understand what is meant by the statement:> What I tend to do 
is put those in the top level of the file system

I guess the storage for the snapshots is meant. So if I understand right 
you have a directory /snapshots in the dir tree where they will be 
stored. I know about the fact that a nested subvolume (subvolume in 
another subvolume) will not get snapshotted. But it is not clear to me 
if you are using this fact in your layout (make i.e. /var/log a separate 
subvolume) or not. Also it is not clear to me, why you put the snapshots 
in the top level of your filesystem.
