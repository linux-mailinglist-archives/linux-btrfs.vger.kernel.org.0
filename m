Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF512715462
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 06:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjE3EGn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 00:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjE3EGl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 00:06:41 -0400
Received: from mail.as397444.net (mail.as397444.net [69.59.18.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C21D94
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 21:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bluematt.me
        ; s=1685418061; h=In-Reply-To:From:References:Cc:To:Subject:From:Subject:To:
        Cc:Reply-To; bh=zNIZ4/sU6FxYobQRLZJ19qYozLAIIx/tzB6s2f6L7as=; b=jOyo3Rioso9Aw
        I1iiJSPUJX3wRULG9/tm+IT0ohrPlYsvFRMSdh1m+G+p7hSE4MVB7fL8J9ocYCPwixTsskVbRc67U
        2y3WUCprsWfYxkMTEJbPyitnCTvL7ciMl7ZrlaMmoWD71aa2Tx5IOyrSRRalZkfvQqDRkSmZLRlCa
        ueDJVLubYwqhR7B2pe1kvPB2IPOdU/SlU4yKifJINAc+CemJQ07rWZYTVz8uO9hos6wRKiQrdI5Jm
        mR6VA8GyizC0lZWZvya2WFp401F2TPYckwJM02xey5HG6GCbrgDJbFBQQhKz6xl9jxARfhektGFfi
        w0QWShUOKAiIhaFNfzgTg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=clients.mail.as397444.net; s=1685418063; h=In-Reply-To:From:References:Cc:
        To:Subject:From:Subject:To:Cc:Reply-To;
        bh=zNIZ4/sU6FxYobQRLZJ19qYozLAIIx/tzB6s2f6L7as=; b=QIROftILRzgqTQx/WQAE/G6Iyk
        scqXX+rpNJ11sUvU+cO1NMYcE42Maid2lAtMUmoObzzgiW8BM/J2O261cu0uKTJ4tTX6r0VIIyotY
        lNEaQvHOIeolBFB37azLk/Ejh2iA2ZIGND2EqX8nfPCWUeKH2H4FSMlBslWE1m+fUpyVunOEdM+4H
        i1gpaQUDvvRkJlWIf+9TQbtXbKg+CAKhqn/VDn9x+G/Iu0kX9bI2X6+t+nI4SWCfplMoV6d3JAM7d
        mC5ifePsvAYiPX4OsjWQBcc1i1S1D/GvgFbkewbjJkhWEo42Jjc7LIDAkBjqwA+x2hiztRiOX/EfC
        wLjvF+LA==;
Received: by mail.as397444.net with esmtpsa (TLS1.3) (Exim)
        (envelope-from <blnxfsl@bluematt.me>)
        id 1q3qd4-002zkM-0K;
        Tue, 30 May 2023 04:06:38 +0000
Message-ID: <398f2d12-afae-075b-7474-8ce1b13a2b88@bluematt.me>
Date:   Mon, 29 May 2023 21:06:37 -0700
MIME-Version: 1.0
Subject: Re: [6.1] Transaction Aborted cancelling a metadata balance
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <bc26e2b2-dcb1-d4a2-771e-82c1dbf4f197@bluematt.me>
 <20230529141933.GH575@twin.jikos.cz>
 <f555f213-f839-445f-7b00-cbf1952d64eb@bluematt.me>
 <1ce06018-3fb5-50b1-813d-5b6d9f2cdcdf@bluematt.me>
From:   Matt Corallo <blnxfsl@bluematt.me>
In-Reply-To: <1ce06018-3fb5-50b1-813d-5b6d9f2cdcdf@bluematt.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DKIM-Note: Keys used to sign are likely public at https://as397444.net/dkim/bluematt.me
X-DKIM-Note: For more info, see https://as397444.net/dkim/
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_LOCAL_NOVOWEL,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_ABUSE_SURBL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5/29/23 1:36 PM, Matt Corallo wrote:
> 
> 
> On 5/29/23 1:23 PM, Matt Corallo wrote:
>> FWIW, after the read-only I unmounted and checked and it came back fine:
>>
>> # btrfs check --readonly --progress /dev/mapper/bigraid21_crypt
>> Opening filesystem to check...
>> Checking filesystem on /dev/mapper/bigraid21_crypt
>> UUID: e2843f83-aadf-418d-b36b-5642f906808f
>> [1/7] checking root items                      (0:09:17 elapsed, 42551370 items checked)
>> [1/7] checking root items                      (0:33:21 elapsed, 144002052 items checked)
>> [2/7] checking extents                         (4:19:44 elapsed, 8488584 items checked)
>> [3/7] checking free space tree                 (0:36:19 elapsed, 31540 items checked)
>> [4/7] checking fs roots                        (9:30:14 elapsed, 5429485 items checked)
>> [5/7] checking csums (without verifying data)  (2:01:44 elapsed, 37437367 items checked)
>> [6/7] checking root refs                       (0:00:00 elapsed, 4344 items checked)
>> [7/7] checking quota groups skipped (not enabled on this FS)
>> found 31304846272026 bytes used, no error found
>> total csum bytes: 30413242320
>> total tree bytes: 139005657088
>> total fs tree bytes: 89334448128
>> total extent tree bytes: 14987935744
>> btree space waste bytes: 22197358915
>> file data blocks allocated: 227202548510720
>>   referenced 43568236474368
> 
> Hmm, so it seems I cannot cancel the balance at all. I remounted after the check came back good, the 
> balance resumed and then I tried to cancel and hit the assert_eb_page_uptodate issue again:


Welp, this filesystem is now basically unusable. On mounting I get a balance resume which generates 
a constant flood of assert_eb_page_uptodate warnings that peg btrfs task CPU. I can cleanly unmount 
it after a while of warn floods, but on remount it doesn't go away, just resumes from where it was.

Is there some way to offline-cancel the balance since I can't cancel it online without hitting the 
transaction abort?

Matt
