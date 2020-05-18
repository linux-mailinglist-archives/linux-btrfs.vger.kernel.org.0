Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199181D7E14
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 May 2020 18:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgERQPE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 May 2020 12:15:04 -0400
Received: from smtp-16.italiaonline.it ([213.209.10.16]:56792 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726958AbgERQPE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 May 2020 12:15:04 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 May 2020 12:15:03 EDT
Received: from [10.4.143.172] ([5.171.62.62])
        by smtp-16.iol.local with ESMTPA
        id aiI1jgYikj8kvaiI1jKTZU; Mon, 18 May 2020 18:06:53 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1589818013; bh=TESd6kOLMoqAErH++zjbPh2egGJz/R26HrYrc1ow1FM=;
        h=From;
        b=p4cQaAR0k/wr770SIo1BK6hQYJwc4HI1cQ9VTNdC2CuMJUPHdxsLsquX/LoBPnn9v
         C8hoYN4qMzv8KEMmS44V5MgC3JIBkDCD4jM7b10cvGwIkh56BOW5e98DprrmWp142W
         yRJB7Q5vCtR/csYB8qs2SCVFdXtaDf0/7dEOWXUDtUbskRd4nThGWLRn63WFYf1Wg9
         dtwSfOxClNz6Vb6HvvWAPsx0N3jH8cz+lcXMBDx2pmmKS2x/wBwMe/eXCsdDWR32/y
         DgB8/h9OMXV8d68AJsptlvgx0OFJQDxTPe7/upsE370y6oMHOW5TUAgLk33+v/eNk0
         o5BfVSwpQ0U8w==
X-CNFS-Analysis: v=2.3 cv=V9gDLtvi c=1 sm=1 tr=0
 a=gdRHAZOQ3OoQmxiyLczz1Q==:117 a=gdRHAZOQ3OoQmxiyLczz1Q==:17
 a=HpEJnUlJZJkA:10 a=IkcTkHD0fZMA:10 a=iox4zFpeAAAA:8 a=t3d8J0w1t5YOCH763iIA:9
 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
Message-ID: <aeaffa7fb6502f288397d95613815d58@smtp-16.iol.local>
Date:   Mon, 18 May 2020 18:06:52 +0200
Subject: Re: how to recover unmountable partition (crash while resizing)?
From:   Antonio Muci <a.mux@inwind.it>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-CMAE-Envelope: MS4wfG0yUW3oubtUaD+w50zLruSydlKyr0sf1E0gCF1Mcy622Tm70zGXPtrYvebeBYrJEiv4zIjTsRpWqS76vMLt7Wc0xtUjsqxPvvlekLiFDWBS+BBptNMt
 HMUJGEhBNjeXjglkJslva8LZhh6U8bmygF2loEI0bYdNmx3At6izRKHdhDnFdiphPA6Tdzos7fI3+tDczZUCIy2M/kgMk68RRX4=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

WWVzLCB0aGF0IHNhbWUgb25lLk9uIE1heSAxOCwgMjAyMCA1OjMzIFBNLCBOaWtvbGF5IEJvcmlz
b3YgPG5ib3Jpc292QHN1c2UuY29tPiB3cm90ZToKPgo+Cj4KPiBPbiAxOC4wNS4yMCDQsy4gMTc6
MTEg0YcuLCBhLm11eEBpbndpbmQuaXQgd3JvdGU6IAo+ID4gSGksIAo+ID4gCj4gPiBkdWUgdG8g
YSBjcmFzaCB3aGlsZSByZXNpemluZyBteSAvIGJ0cmZzIHBhcnRpdGlvbiB3aXRoIGdwYXJ0ZWQs
IG15IEhEIHdhcyBsZWZ0IGluIGEgdW5tb3VudGFibGUgc3RhdGUuIAo+ID4gCj4gPiBUaGlzIGlz
IG9uIG1lOiByZXNpemluZyBhIHBhcnRpdGlvbiBtb3ZpbmcgaXQgdG8gdGhlIHJpZ2h0IHZpYSBn
cGFydGVkIGlzIGEgcmlza3kgb3BlcmF0aW9uIHBlciBzZS4gCj4gPiAKPiA+IEkgYW0gY29uZmlk
ZW50IHRoYXQgYWxsIG15IGRhdGEgaXMgc3RpbGwgaW4gdGhlIEhELCBhbmQgd2l0aCBwcm9wZXIg
Z3VpZGFuY2UgZnJvbSB0aGUgdG9vbHMgaXQgd2lsbCBiZSBwb3NzaWJsZSB0byBtb3VudCBiYWNr
IHRoZSBmcy4gVGhlIFVJIG9mIHRoZSB0b29scyBpcyBhIGJpdCBoYXJkIGZvciBtZSB0byB1bmRl
cnN0YW5kLiAKPgo+IFNvIHdoYXQga2VybmVsIHZlcnNpb24gd2VyZSB5b3UgcnVubmluZyB3aGVu
IHRoZSBjcmFzaCBoYXBwZW5lZCwgaXMgaXQgCj4gdGhlIHNhbWUgYXMgZnJvbSBMaXZlVVNCPyAK

