Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BB4405A41
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Sep 2021 17:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbhIIPkh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Sep 2021 11:40:37 -0400
Received: from a4-2.smtp-out.eu-west-1.amazonses.com ([54.240.4.2]:45933 "EHLO
        a4-2.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229745AbhIIPkg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Sep 2021 11:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=vbsgq4olmwpaxkmtpgfbbmccllr2wq3g; d=urbackup.org; t=1631201965;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=OU5SBBwjwyQouvpQ8WXrMPiqxu1NXr04IWqA1Fd8cBM=;
        b=dQwYL8c+6Fl2rvKNlnx1qidjhq7faLrykwo657Ya37ag8iKHo4GYt6cx807dnBAl
        24LkUW3GtUlwT5GC7zDwp40FdHgxLFq/iw4u+TiELfBPC4I/T1LZhpNZOWTCyGXIY/K
        3ATfybuGQTej983xJ0GZaTW30jivb++DH2b19lec=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1631201965;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=OU5SBBwjwyQouvpQ8WXrMPiqxu1NXr04IWqA1Fd8cBM=;
        b=SMr/VH5VUfVjztrmWr9eC0XOw10k/fyTHeMuHT2UjD/XomDVCdMK8CNsYp719Oi1
        ay0QblBPV8d+3bBr31cN0rqiPnJLA8YcAPdrPiP+xCInhr04TGsNV5Y7JcAOXAPg2Su
        Iy2GQrj8EqHO3zI1IG7WsC01ZWNSoGhapwxG01QE=
Subject: Re: [PATCH v2] btrfs: Remove received information from snapshot on
 ro->rw switch
To:     Graham Cobb <g.btrfs@cobb.uk.net>,
        Nikolay Borisov <nborisov@suse.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org
References: <20210908135135.1474055-1-nborisov@suse.com>
 <0102017bc64308e0-f75c4f13-349c-4c2c-a77d-f037340f07c1-000000@eu-west-1.amazonses.com>
 <20210908183312.GU3379@twin.jikos.cz>
 <44c16ed8-89fe-a38b-0304-a84dfd4a5335@cobb.uk.net>
 <50fea163-afe6-bb4a-04c5-f3e4ed4c6bd3@suse.com>
 <b15813b9-bd23-e2a5-b8a4-1c2fcbb0e019@cobb.uk.net>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <0102017bcb36b388-4e540593-6da5-495d-ba53-ee8d5245c050-000000@eu-west-1.amazonses.com>
Date:   Thu, 9 Sep 2021 15:39:25 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <b15813b9-bd23-e2a5-b8a4-1c2fcbb0e019@cobb.uk.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
X-SES-Outgoing: 2021.09.09-54.240.4.2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 09.09.2021 11:37 Graham Cobb wrote:
> On 09/09/2021 07:46, Nikolay Borisov wrote:
>
>
> On 9.09.21 г. 0:24, Graham Cobb wrote:
>>> On 08/09/2021 19:33, David Sterba wrote:
>>>> On Wed, Sep 08, 2021 at 04:34:47PM +0000, Martin Raiber wrote:
>>> <snip>
>>>
>>>>> For example I had the problem of partial subvols after a sudden
>>>>> restart during receive. No problem, just receive to a directory that
>>>>> gets deleted on startup then move the subvol to the final location
>>>>> after completion. To move the subvol it needs to be temporarily set rw
>>>>> for some reason. I'm sure there is some better solution but patterns
>>>>> like this might be out there.
>>>> Thanks, that's a case we should take into account. And there are
>>>> probably more, but I'm not using send/receive much so that's another
>>>> reason why I've been hesitant to merge the patch due to lack of
>>>> understanding of the use case.
>>>>
>>> This seems to be an important change to make, but is user-affecting. A
>>> few ideas:
>>>
>>> 1) Can it be made optional? On by default but possible to turn off
>>> (mount option, sys file, ...) if you really need to retain the current
>>> behaviour.
>> But the current behavior is buggy and non-intentional so it should be
>> rectified. Basically we've made it easy for users to do something which
>> they shouldn't really be doing, they then bear the consequences and come
>> to the mailing list for support thinking something is broken.
> Yes, I agree completely. I was disappointed the change wasn't made last
> time this was discussed on the list. But it wasn't. And I think that was
> because of concern over the impact: the change will break some users'
> workflows or scripts and could break some important tools, apps or
> things like distro installation/upgrade scripts. That was the purpose of
> my suggestions: to break down barriers which might delay making this happen.
>
>>> 2) Is there a way to engage with the developers and user community for
>>> popular tools which make heavy use of snapshotting and/or send/receive
>>> for discussion and testing? For example, btrbk, snapper, distros.
> The point of this suggestion was to address David's concern of not
> understanding the use case. This could be useful when discussing the
> timing of the fix (and whether it can be backported to stable kernels).
>
>>> 3) How about adding an IOCTL to allow the user to set/delete the
>>> received_uuid? Only intended for cases which really need to emulate the
>>> removed behaviour. This could be a less complex long term solution than
>>> keeping option 1 indefinitely.
> And this suggestion was to make it "possible" to work round the change
> but, in practice, harder than just doing the right thing :-) I agree
> this is probably too far.

5) Have a new subvol flag and only reset received uuid on ro -> rw if this new subvol flag is set. At this point it is completely backwards compatible (if older kernels ignore unknown subvol flags?). Then change btrfs-progs to set this flag during receive (under whatever policy btrfs-progs has for backwards-compatibility). Maybe only for v2 streams but that might further delay the transition. btrfs_ioctl_received_subvol_args even has an already existing flags member.

