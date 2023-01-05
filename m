Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A01465F144
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jan 2023 17:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjAEQf0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Jan 2023 11:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjAEQfX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Jan 2023 11:35:23 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F385C92E
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Jan 2023 08:35:21 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 7F8C3240596
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Jan 2023 17:35:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1672936520; bh=ESKrs/d90TEx4Lj4lMd5nAYQ7dSbVxZ4UACUh9ociaY=;
        h=Date:Subject:To:Cc:From:From;
        b=ck0/L3hi3p9qOmi0tQ9q/7HaMfA61iS2ZM+fUvaTkIuft2Ju38bkzUsLMFzjijUx7
         U8GDJt7vmbPJuz1fzpIvj323ELeqrMuOyXHBwVbhLecT7NuravqdUxhtN3JX0vSSxT
         wk9isMEG+jetPnw/xSuVmZdkuDzMmj7oKDBMskxoHKHZ07OtwI2NYQVvSSDEyJJgrN
         ro4XzVzu97P6+CkrPuaO8gBhZ2Jrv3E7Vih40SD7pv5G7zzYbGECg2LdBSkuu5oFTX
         J4/3W9fhwtjtX0k77vOhKDMC+5XHCzeZ2RNR7DAp/5nFlZw0YXDHNCvlLkVGPVjZ1L
         IJnNlRkdt9X5g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4NnsX76nL7z6tmN;
        Thu,  5 Jan 2023 17:35:19 +0100 (CET)
Message-ID: <13c659bb-9238-4e06-6e3f-27f9c52774e3@posteo.de>
Date:   Thu,  5 Jan 2023 16:35:19 +0000
MIME-Version: 1.0
Subject: Re: btrfs send and receive showing errors
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
Content-Language: de-DE
From:   =?UTF-8?Q?Randy_N=c3=bcrnberger?= <ranuberger@posteo.de>
In-Reply-To: <76b72107-71c0-bbe7-c20e-2b26dba24abe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 5, 2023 at 17:01, Andrei Borzenkov wrote:
> On 05.01.2023 18:55, Randy Nürnberger wrote:
>>
>> I’ve attached the output of ‘btrfs subvolume list’ for the source and
>> the target filesystem.
>>
>
> You have a lot of source subvolumes with the same received_uuid and 
> you have at least two destination subvolumes with the same 
> received_uuid. This is wrong, received_uuid is supposed to be unique 
> identification which explains your errors (incorrect subvolume is 
> selected).

I guess many of my source subvolumes have the same received_uuid, 
because I created new snapshots from a snapshot that was previously 
received and the received_uuid just did get copied.

I just did a small experiment on another system, created a snapshot from 
a snapshot that previously was received and could confirm that the 
received_uuid does indeed get copied. Is this a problem?
