Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3C265F163
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jan 2023 17:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbjAEQrV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Jan 2023 11:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjAEQrT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Jan 2023 11:47:19 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9062BB94
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Jan 2023 08:47:18 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 20157240473
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Jan 2023 17:47:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1672937237; bh=2MMqiSHV+6+GeUSSvtNwoBQX+xYP3UYuvVMsDqIA+3A=;
        h=Date:Subject:From:To:Cc:From;
        b=mptxO9FaJnqvB6xSov3hKOYTbZhJSNaZ6fqmy681Em3xtLLMKcMl2rWOsxkFvN/7l
         /nb7UBEeEBPb0H6B6PR/ljfgBIm1CVz8TeKPhIIt3xZxpn17H0N5yRX4qAVno7Tc6G
         69gPbF/ARssc9GeAjABR+rF4/QTTdeMYKR3h7IIUNdt8aIs2YfmC1jUo461CYqoluD
         G/YbEOTfR9UAVSdtBheyXEWbXNFO3GpOQoWIThYNXFBn/wmO/elUPe7vIS2nyTTgLs
         LkNIcwlgVpFQBFgXXGde08xvE6XvkizvoxEb7RUV6SXQHJO+36Bi+1mt8ubP+giCA3
         31X4pmtUohc+w==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Nnsnw48P6z6tmV;
        Thu,  5 Jan 2023 17:47:16 +0100 (CET)
Message-ID: <63e8183f-dffb-3ac9-e791-f59e85d2f093@posteo.de>
Date:   Thu,  5 Jan 2023 16:47:16 +0000
MIME-Version: 1.0
Subject: Re: btrfs send and receive showing errors
Content-Language: de-DE
From:   =?UTF-8?Q?Randy_N=c3=bcrnberger?= <ranuberger@posteo.de>
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
References: <b732e1e7-7b3a-cfa7-1345-d39feaa6a7a8@posteo.de>
 <CAL3q7H72Z7v038psf9rPSjfWn96WDbxpbRx_73HAPvzzV4SB8g@mail.gmail.com>
 <0ee56d23-9a3d-08ea-a303-e995c99d3f43@posteo.de>
 <CAL3q7H4+A1mW5+hrVj-OZT8bGnaOQWCzwWJESquS0-aEu7teKg@mail.gmail.com>
 <58eef5ef-b066-b2cd-e465-6bab43c1c748@posteo.de>
 <82ee24b6-fa58-b03e-7765-b157556a2b37@gmail.com>
 <cba9edbc-bde4-00e4-0f73-5063f5aef11d@posteo.de>
 <76b72107-71c0-bbe7-c20e-2b26dba24abe@gmail.com>
 <13c659bb-9238-4e06-6e3f-27f9c52774e3@posteo.de>
In-Reply-To: <13c659bb-9238-4e06-6e3f-27f9c52774e3@posteo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 5, 2023 at 17:35, Randy Nürnberger wrote:
> On Thu, Jan 5, 2023 at 17:01, Andrei Borzenkov wrote:
>> On 05.01.2023 18:55, Randy Nürnberger wrote:
>>>
>>> I’ve attached the output of ‘btrfs subvolume list’ for the source and
>>> the target filesystem.
>>>
>>
>> You have a lot of source subvolumes with the same received_uuid and 
>> you have at least two destination subvolumes with the same 
>> received_uuid. This is wrong, received_uuid is supposed to be unique 
>> identification which explains your errors (incorrect subvolume is 
>> selected).
>
> I guess many of my source subvolumes have the same received_uuid, 
> because I created new snapshots from a snapshot that was previously 
> received and the received_uuid just did get copied.
>
> I just did a small experiment on another system, created a snapshot 
> from a snapshot that previously was received and could confirm that 
> the received_uuid does indeed get copied. Is this a problem?

Ha! This seems to be the problem! I’m able to write a small script that 
reproduces the bug! Give me a couple minutes.

If this is a bug in the kernel, may I write the patch? :D Would be my 
first one :)
