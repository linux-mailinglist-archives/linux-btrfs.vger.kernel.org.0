Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD36319281
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Feb 2021 19:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhBKSsG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Feb 2021 13:48:06 -0500
Received: from smtp-17.italiaonline.it ([213.209.10.17]:49128 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230239AbhBKSrw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Feb 2021 13:47:52 -0500
Received: from venice.bhome ([78.12.25.19])
        by smtp-17.iol.local with ESMTPA
        id AGzelzLr9lChfAGzelGA2R; Thu, 11 Feb 2021 19:47:10 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1613069230; bh=H1eleJn14KtWLZFhpEEaKjL7OLPje4Z/bOTvTjk280g=;
        h=From;
        b=jJVYs3U1rGHr4Ryx9rCnKbgqaOmyK4vwIxLZJl9kkCS6TJ7q7pXizNx6k2yIchSXe
         o1Erx4cYAxCN0leU3a9yoT+HYkxCPxwg/MSWfoanzv2RbgpaWTEOVrY5+puG+VaYev
         UfMvz7rult+/+Irf+k+BfSh/AfZIfvYscOHvzq/5d8TqAosoz3PoZWFGLMj/B1HXDE
         wCSi1aggzhH3bCPbe2zK9/3arKXZkk4I7kp8KMZHWAB2lkjmnOJxDbiXWKl2AUk93+
         oL8qN3iziDlFa3QeYr541lLBW9KQXtlcDtOkwewUq+9py3NzJTZPQLqSgQqE+HqX68
         q7BAYW5q1aC9w==
X-CNFS-Analysis: v=2.4 cv=S6McfKgP c=1 sm=1 tr=0 ts=60257bae cx=a_exe
 a=cZ/q60u+NbBn6HfapJxCHg==:117 a=cZ/q60u+NbBn6HfapJxCHg==:17
 a=IkcTkHD0fZMA:10 a=dfLDlhdaAAAA:20 a=1Gyu_1izjD1103tOAiYA:9
 a=QEXdDO2ut3YA:10 a=CtvLCtAli4LrSFkZZ_cB:22
Reply-To: kreijack@inwind.it
Subject: Re: [RFC][PATCH V6] btrfs: allocation_hint mode
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <20210201212820.64381-1-kreijack@libero.it>
 <df7f0dd3-d648-ea9f-2856-7034a6833a51@toxicpanda.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <d21f9fec-6ed3-c49c-e274-4879166d9d57@libero.it>
Date:   Thu, 11 Feb 2021 19:47:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <df7f0dd3-d648-ea9f-2856-7034a6833a51@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfK/2/RsF9OnLYdGl1L0Ts3TOb7MN4BNbkcwLmD+Z/HEkFRN1kw8S6FPtKjAKJKS2/toUuJbGLsMZjeAVvFESO+y1wn4SQZFJ3Fu7tNmFzpERWQhTaz87
 CBAp1du043I/qW/CDvHGAXcB60ut02L/oq95R4RO44tkVp/AnWlHfXq+yIN4cQgq1CijtDuMcl0tqgcD5mtKDeohw9HMsibN0pFidQul4EYNiKlcl2TM6u92
 /OkY4NZJU6wW/cfbtZBlIiZVhfY9IhWolSqy9BAI1Lw=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/10/21 5:04 PM, Josef Bacik wrote:
> On 2/1/21 4:28 PM, Goffredo Baroncelli wrote:
>>
>> Hi all,
>>
>> the previous V5 serie was called "btrfs: preferred_metadata: preferred device
>> for metadata".
>>
> 
> A few general points up front, first I'd highly recommend reading our patch submission guidelines
> 
> https://github.com/btrfs/btrfs-workflow/blob/master/patch-submission.md
> 
> specifically the 'Git config options' section, as it tells you how to apply our git hooks to your local repo.  This will check your patches for all the automatic formatting things we'll complain about, that way you don't have to get bogged down in those style of comments in the review.  For example as soon as I started applying your patches I was getting a ton of whitespace warnings, these are better caught before sending them along.
> 
ok
> Also try to develop on Dave's misc-next branch.  I realize this is a moving target, so I'm fine with massaging patches so I can review, but again everything needed massaging.
> 
ok
> And finally for a new feature we're going to need an xfstest or two in order to merge them.  I realize we're still working out the details, but the further you get into this it would be good to go ahead and have a test that validates everything.  Thanks,

Definitely I have to do it. Unfortunately the last time I tried I found complex to setup it. Do you have some link for an "xfstest beginner" ?
> 
> Josef


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
