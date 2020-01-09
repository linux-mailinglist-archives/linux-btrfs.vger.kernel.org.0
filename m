Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1F9F135EDF
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2020 18:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387821AbgAIRHG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 12:07:06 -0500
Received: from zaphod.cobb.me.uk ([213.138.97.131]:41884 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731444AbgAIRHG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jan 2020 12:07:06 -0500
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 27ECE9C363; Thu,  9 Jan 2020 17:07:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1578589624;
        bh=7wLvu3GPZePDzO8forIveiUPApnHZzunQr8L0rJFc+Q=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=SQEEGOSoHQ6xc5LJARnqxgaCtTnNt5wFiOJRR24PUNZZa9oow83gU+jw/LYgTDjPh
         FkIhROEmJ9NC1GZiJ96+HLrvKXY8ehDiq+EyyQvUByX5T3BLqQat1sDuxDHS0l2lPS
         QozSg37TCd1ilMYIO2sot0Otoji9Q1ef3IvFHD5LWM9oaN/4Y8yLgVmOslc3KNmmkM
         b0KK1D4lbiRUAZ7UY4WdpkHVcmI0KlI7H9of08fJn66BN/otGaLRjyZ9R70ckElrpS
         YwMMJGLLY8SDBfCak+38rTsxo9P9crZkiUsqtrOFswpz6K5uhkBtb0y+qV3LZ79Ewh
         60EHjmBxRovag==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 5C92F9C357;
        Thu,  9 Jan 2020 17:06:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1578589619;
        bh=7wLvu3GPZePDzO8forIveiUPApnHZzunQr8L0rJFc+Q=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=RzUAef60mUvk70fRBx0W4kSY0aWli5j4G/dd4oIwbgETaA0vc0mHKbRWYskJXLXzg
         tHJ7ynGU3iNKhjPqMUt/+x6fZoZVv5r2XgnXoFqhBILM64Sv8+NNaPV3yANhR1NzBv
         p5mE0R6VUq78XjW6BeXCnS06X5FaE+fYztX0+Zv06hwWdYFYKTx0CjSs3988jngscC
         DSInrUwllqpsbQ9p4Y3TOLf267FwuPV2FSrKuTeiOX5XFHxQ3/kKVS+d+t07kzLV6+
         bK2Vv/pYQjNldRqeOB2FSGIzPrwlRo/33x/Z7vWkpM4JTrqMotemB+eQr0kqX1Bsl/
         fvosT2g1HtDTA==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 04FA9A0508;
        Thu,  9 Jan 2020 17:06:59 +0000 (GMT)
Subject: Re: btrfs scrub: cancel + resume not resuming?
To:     =?UTF-8?Q?Sebastian_D=c3=b6ring?= <moralapostel@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CADkZQakAhrRHFeHPJfne5oLT81qFGbzNAiUoqb3r0cxVSuHTNg@mail.gmail.com>
 <654bf850-65bf-65f5-2ed2-90a0d4058e74@cobb.uk.net>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <b1ef69cc-0861-ec6c-aa98-54bb66b2471f@cobb.uk.net>
Date:   Thu, 9 Jan 2020 17:06:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <654bf850-65bf-65f5-2ed2-90a0d4058e74@cobb.uk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 09/01/2020 10:19, Graham Cobb wrote:
> On 09/01/2020 10:03, Sebastian Döring wrote:
>> Maybe I'm doing it entirely wrong, but I can't seem to get 'btrfs
>> scrub resume' to work properly. During a running scrub the resume
>> information (like data_bytes_scrubbed:1081454592) gets written to a
>> file in /var/lib/btrfs, but as soon as the scrub is cancelled all
>> relevant fields are zeroed. 'btrfs scrub resume' then seems to
>> re-start from the very beginning.
>>
>> This is on linux-5.5-rc5 and btrfs-progs 5.4, but I've been seeing
>> this for a while now.
>>
>> Is this intended/expected behavior? Am I using the btrfs-progs wrong?
>> How can I interrupt and resume a scrub?
> 
> Coincidentally, I noticed exactly the same thing yesterday!
> 
> I have just run a quick test. It works with kernel 4.19 but doesn't with
> kernel 5.3. This is using exactly the same version of btrfs-progs:
> v5.3.1 (I just rebooted the same system with an old kernel to check).
> 
> As Sebastian says, the symptom is that the file in /var/lib/btrfs shows
> all fields as zero after the cancel (although "cancelled" and "finished"
> are both 1). In particular, last_physical is zero so the scrub always
> resumes from the beginning.
> 
> With the old kernel, the file in /var/lib/btrfs correctly has all the
> values filled in after the cancel so the scrub can be resumed.

I have spent the last couple of hours instrumenting the code of scrub.c
to try to work out what is going on. The relationship between the main
thread, the thread where the scrub is running and the thread where the
status updates are being received from the kernel is quite horrible. Not
to mention that two of these three threads write out what could be the
final version of the progress file (and use different data structures as
the source for that write!).

The basic problem is that the scrub program seems to assume it will have
seen the cancellation in the update stream *before* the ioctl completes
with the cancelled status. And that seems to happen the other way round
in the 5.x kernel. Although I haven't done an actual comparison with a
4.19 run to check this.

What I haven't checked, yet, is if the 5.x kernel does actually send the
final data update if we stick around long enough to receive it.
