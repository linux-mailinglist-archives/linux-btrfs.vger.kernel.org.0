Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F704A53FC
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Feb 2022 01:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiBAAV1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jan 2022 19:21:27 -0500
Received: from mout.gmx.net ([212.227.17.22]:50205 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230344AbiBAAV1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jan 2022 19:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643674885;
        bh=wRJ0S2jagV3I42IGkJ6B0b9yqXiL99rh2uD7YpfugBI=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=R5nf7G4FPUdCEXO37brOix2YkmG15RRTTkrl7C2z2HM30UJj6t7PhaNthwRUkkEVM
         IxdYBrfgir/VV+Zg/KCrg+OX0bqJASGCzfKMUc+cOOcMq3XlzfE9CRmGnndMr+/i+U
         wPRb5NILWJC3p73vJK/sYvI8Q9PqVQG1Gb/nJZgk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N63RQ-1m8VOG2xbc-016SLj; Tue, 01
 Feb 2022 01:21:25 +0100
Message-ID: <f5d1c08b-b843-6d5d-341d-c19890872e04@gmx.com>
Date:   Tue, 1 Feb 2022 08:21:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     Sidong Yang <realwakka@gmail.com>, linux-btrfs@vger.kernel.org
References: <20220131154040.GA25010@realwakka>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: A question for kernel code in btrfs_run_qgroups()
In-Reply-To: <20220131154040.GA25010@realwakka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:40JUDdhfuUxnx8NQwQRRzn0FJiDVlmd9gYElhPcWue1cvkSIcyZ
 EyzyKcEOsEkhm1LeuvvHCBt/bjPmIMW3G47Bc+27C8NJj4bRPvFgYKUGhKQTR9ayhPYMUY5
 kIA3s/TDIC855iMPBPETvyJjlDdJdj5TNhtCHEGNOtzTnXTbHlg7lWpphPNEo/GxhhzhAOR
 Bvbq2C4e4ThC35G0eBD4g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:X6TWTdfu/SM=:VpFCAE8e1gtfCi6i8qbWMC
 BuCVZakzSA6whWMxppj4//i0cHSyKCSpLVHMyyfvHwqeoNsIYrF37vJQFyg+SxUAfmDPDyDeQ
 Lq34gS2DM0kKw0PNSgZJNJHjdhSyy3vzuV4VA4Qd3jz3xAaMSGqlR1qyBBoqSJCMjlTRMLH67
 vD2eQTJnNJ6Jjy9VM6oSxLDJFJpaFKVzOGRbYX5S1o9RxFxRh+FBiwaWu58joRvZIZCX8IrgS
 5MPruxodeG3fJvyGMh6EG/pKLWYJ6UqKfEsi1AazrppQnHjdELi5QruFwxISFzG7FTtMwiD/K
 usOtpHl3eY0VjKGsr9HlUFzL53Uc2vE2mmPxQGvaWsw9AhIE9SlTzstHjLUB8furP4gkp9GjE
 jMcgVfrjvJNk83K4KglVQfUzbJczSQ4iv3+vFD459SybitwQxt3PdophmJFIRJFGxzk5w0/3x
 pA6wazhzqUPHbVfB3oE8J7YJG451477dkC7828z2lJZSVGZZ3Nd3yptuyueNhdpJWlcTOUl8F
 P2/ywtxCm0wdLrAuau7QpG1uY2l7hdy6He1ljfCw3eOZOG72IXjetv8cN0ogc4eSaUM7uujvb
 WAwFD4JvcChNdJ57hb1ybBlLv8nfG94Nyt1dDMgmgvmA0BCHJi3LoQ+94BZlPnXR2v+s5wB7M
 kdicCP/cVmFhI4zYJvN2FlYdeNwiytEewqnCTPYfG+Z3cXtsGZcKf/dXXEMmLKlvbOXkXstQ8
 1YoQBgtOH54kVFfIMQHdWByIRAH4fGp/rIpTchu+0jnNBlvhYDCE3kkp9uspQRqBnz7U3DnNL
 M7qID6gnIKE8M6UHpAXN4EfiiPeFLsTvUfm0hGMtCddthzr9+BPuM4S/ItVQNyKnTHZXkMBbR
 +6Z4jAtVZk7SjHpp0y3b0llxHvE2q74cRauuUDN4FALU8jb7FonW+o4nsiviHEp6L8NDJav5v
 S0FoHC8goAcnfyQFKnlEO+BjC+O1WtyIyKkKmicrpgKpaSokEBBopaKMgEnOxKEPi/MFVwpgQ
 EKk6BHrJcefCfSRjkbCyez2ZqUiDsHae1YuJkRALXK3r29b/y0G7wHieTyTgXk+xLKzJo/6eI
 3YushiPkF5Fhsk=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/31 23:40, Sidong Yang wrote:
> Hi, I'm reading btrfs code for contributing.
> I have a question about code in btrfs_run_qgroups().
>
> It seems that it updates dirty qgroups modified in transaction.

Yep.

> And it iterates dirty qgroups with locking and unlocking qgroup_lock for
> protecting dirty_qgroups list. According to code, It locks before enter
> the loop and pick a entry and unlock. At the end of loop, It locks again
> for next loop. And after loop, it set some flags and unlock.
>
> I wonder that it should be locked with setting STATUS_FLAG_ON? if not,
> is there unnecessary locking in last loop?

 From a quick look, it indeed looks like we don't need to hole
qgroup_lock to modify qgroup_flags.
In fact, just lines below, we update qgroup_flags without any lock for
INCONSISTENT bit.


Unfortunately we indeed have inconsistent locking for qgroups_flags.

So it's completely possible that we may not need to do modify the
qgroup_flags under qgroup_lock.

In fact there are tons of call sites that we don't hold locks for
qgroups_flags update.

So if you're interested in contributing to btrfs, starting from sorting
the qgroup_lock usage would be a excellent start.

Thanks,
Qu
