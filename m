Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 018A621AB9
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 17:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbfEQPgL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 11:36:11 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:37526 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbfEQPgL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 11:36:11 -0400
X-Greylist: delayed 458 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 May 2019 11:36:10 EDT
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 94FCE142BC3; Fri, 17 May 2019 16:28:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1558106910;
        bh=fdtlg3ydregXD701IqH0f3JBQTY1NfIknl1HAsY/N8s=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=AKU+5VFmDzswX6kWQM0HJQbirj2/Hc6ZRXxQ9Lu3j+pCKP6RcP9piwL694kVf97o4
         VRVTYRsWcqC788eDh0k3w0tH8JHJEwUX8C8oFjRkH2nvw+sQt85TfT2N6Ayd1pDrpF
         +hkh6lfFFBR3jkdvegJ9iDLF4SEYhBx4cOLeUNPhAzbZ91/5PTZmp5FdrELegnp7u6
         JYwgdVrfoddrlSQ3dun5Lko+t+wHR81smSzfY1+HrCF1VAteGIw+H5DRZ2fTrOaqY3
         2wfhcegozea9fWElUQmGDADC8vBVnigHcsOmhaQEhxKkEIAzKtEIwIFI2jgWgM7vT/
         weQ2j278uU1pQ==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id D7199142BC2
        for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2019 16:28:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1558106908;
        bh=fdtlg3ydregXD701IqH0f3JBQTY1NfIknl1HAsY/N8s=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=wqHoB8QbSx7yw2ACfsluF1ak/+PKPhXyTZ08MSebfVWCsRMI8+ZasM2oJ5rbB0S0W
         PRyGmNwrBKsUakNbo6I4Q/XcNpBXUJbcwUbNePG6uOuGQfR6wvWIFKbpPfCxwEwA8j
         riGkxzLZLNSCIdgUoqNvNz0+k0uu+Y3bRfcb627MoLi8zT+/P+W4JA5pVjE0wGG4cY
         yZo4c7+qQeFhZyhON7KXvJ7e0axOT44pKfBZ2f4wA+l7TUBe5cZkmpEvb0t1AplF8a
         JnKiADyusGlGMHRbbDjiAqP/fDb5Sih6VuwhkhTWITbXr8W5mop9xUefY8DY6Mku/F
         +X9yl2/tkskWA==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 916AF68D9A
        for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2019 16:28:28 +0100 (BST)
Subject: Re: Used disk size of a received subvolume?
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <c79df692-cc5d-5a3a-1123-e376e8c94eb3@tty0.ch>
 <20190516171225.GH1667@carfax.org.uk>
 <27af7824-f3e9-47a5-7760-d3e30827a081@tty0.ch>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 mQINBFaetnIBEAC5cHHbXztbmZhxDof6rYh/Dd5otxJXZ1p7cjE2GN9hCH7gQDOq5EJNqF9c
 VtD9rIywYT1i3qpHWyWo0BIwkWvr1TyFd3CioBe7qfo/8QoeA9nnXVZL2gcorI85a2GVRepb
 kbE22X059P1Z1Cy7c29dc8uDEzAucCILyfrNdZ/9jOTDN9wyyHo4GgPnf9lW3bKqF+t//TSh
 SOOis2+xt60y2In/ls29tD3G2ANcyoKF98JYsTypKJJiX07rK3yKTQbfqvKlc1CPWOuXE2x8
 DdI3wiWlKKeOswdA2JFHJnkRjfrX9AKQm9Nk5JcX47rLxnWMEwlBJbu5NKIW5CUs/5UYqs5s
 0c6UZ3lVwinFVDPC/RO8ixVwDBa+HspoSDz1nJyaRvTv6FBQeiMISeF/iRKnjSJGlx3AzyET
 ZP8bbLnSOiUbXP8q69i2epnhuap7jCcO38HA6qr+GSc7rpl042mZw2k0bojfv6o0DBsS/AWC
 DPFExfDI63On6lUKgf6E9vD3hvr+y7FfWdYWxauonYI8/i86KdWB8yaYMTNWM/+FAKfbKRCP
 dMOMnw7bTbUJMxN51GknnutQlB3aDTz4ze/OUAsAOvXEdlDYAj6JqFNdZW3k9v/QuQifTslR
 JkqVal4+I1SUxj8OJwQWOv/cAjCKJLr5g6UfUIH6rKVAWjEx+wARAQABtDNHcmFoYW0gQ29i
 YiAoUGVyc29uYWwgYWRkcmVzcykgPGdyYWhhbUBjb2JiLnVrLm5ldD6JAlEEEwECADsCGwEG
 CwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAhkBBQJWnr9UFRhoa3A6Ly9rZXlzLmdudXBnLm5l
 dAAKCRBv35GGXfm3Tte8D/45+/dnVdvzPsKgnrdoXpmvhImGaSctn9bhAKvng7EkrQjgV3cf
 C9GMgK0vEJu+4f/sqWA7hPKUq/jW5vRETcvqEp7v7z+56kqq5LUQE5+slsEb/A4lMP4ppwd+
 TPwwDrtVlKNqbKJOM0kPkpj7GRy3xeOYh9D7DtFj2vlmaAy6XvKav/UUU4PoUdeCRyZCRfl0
 Wi8pQBh0ngQWfW/VqI7VsG3Qov5Xt7cTzLuP/PhvzM2c5ltZzEzvz7S/jbB1+pnV9P7WLMYd
 EjhCYzJweCgXyQHCaAWGiHvBOpmxjbHXwX/6xTOJA5CGecDeIDjiK3le7ubFwQAfCgnmnzEj
 pDG+3wq7co7SbtGLVM3hBsYs27M04Oi2aIDUN1RSb0vsB6c07ECT52cggIZSOCvntl6n+uMl
 p0WDrl1i0mJUbztQtDzGxM7nw+4pJPV4iX1jJYbWutBwvC+7F1n2F6Niu/Y3ew9a3ixV2+T6
 aHWkw7/VQvXGnLHfcFbIbzNoAvI6RNnuEqoCnZHxplEr7LuxLR41Z/XAuCkvK41N/SOI9zzT
 GLgUyQVOksdbPaxTgBfah9QlC9eXOKYdw826rGXQsvG7h67nqi67bp1I5dMgbM/+2quY9xk0
 hkWSBKFP7bXYu4kjXZUaYsoRFEfL0gB53eF21777/rR87dEhptCnaoXeqbkBDQRWnrnDAQgA
 0fRG36Ul3Y+iFs82JPBHDpFJjS/wDK+1j7WIoy0nYAiciAtfpXB6hV+fWurdjmXM4Jr8x73S
 xHzmf9yhZSTn3nc5GaK/jjwy3eUdoXu9jQnBIIY68VbgGaPdtD600QtfWt2zf2JC+3CMIwQ2
 fK6joG43sM1nXiaBBHrr0IadSlas1zbinfMGVYAd3efUxlIUPpUK+B1JA12ZCD2PCTdTmVDe
 DPEsYZKuwC8KJt60MjK9zITqKsf21StwFe9Ak1lqX2DmJI4F12FQvS/E3UGdrAFAj+3HGibR
 yfzoT+w9UN2tHm/txFlPuhGU/LosXYCxisgNnF/R4zqkTC1/ao7/PQARAQABiQIlBBgBAgAP
 BQJWnrnDAhsMBQkJZgGAAAoJEG/fkYZd+bdO9b4P/0y3ADmZkbtme4+Bdp68uisDzfI4c/qo
 XSLTxY122QRVNXxn51yRRTzykHtv7/Zd/dUD5zvwj2xXBt9wk4V060wtqh3lD6DE5mQkCVar
 eAfHoygGMG+/mJDUIZD56m5aXN5Xiq77SwTeqJnzc/lYAyZXnTAWfAecVSdLQcKH21p/0AxW
 GU9+IpIjt8XUEGThPNsCOcdemC5u0I1ZeVRXAysBj2ymH0L3EW9B6a0airCmJ3Yctm0maqy+
 2MQ0Q6Jw8DWXbwynmnmzLlLEaN8wwAPo5cb3vcNM3BTcWMaEUHRlg82VR2O+RYpbXAuPOkNo
 6K8mxta3BoZt3zYGwtqc/cpVIHpky+e38/5yEXxzBNn8Rn1xD6pHszYylRP4PfolcgMgi0Ny
 72g40029WqQ6B7bogswoiJ0h3XTX7ipMtuVIVlf+K7r6ca/pX2R9B/fWNSFqaP4v0qBpyJdJ
 LO/FP87yHpEDbbKQKW6Guf6/TKJ7iaG3DDpE7CNCNLfFG/skhrh5Ut4zrG9SjA+0oDkfZ4dI
 B8+QpH3mP9PxkydnxGiGQxvLxI5Q+vQa+1qA5TcCM9SlVLVGelR2+Wj2In+t2GgigTV3PJS4
 tMlN++mrgpjfq4DMYv1AzIBi6/bSR6QGKPYYOOjbk+8Sfao0fmjQeOhj1tAHZuI4hoQbowR+ myxb
Message-ID: <811bcd96-5a8e-cb10-7efb-22c1046e0f42@cobb.uk.net>
Date:   Fri, 17 May 2019 16:28:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <27af7824-f3e9-47a5-7760-d3e30827a081@tty0.ch>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/05/2019 14:57, Axel Burri wrote:
> btrfs fi du shows me the information wanted, but only for the last
> received subvolume (as you said it changes over time, and any later
> child will share data with it). For all others, it merely shows "this
> is what gets freed if you delete this subvolume".

It doesn't even show you that: it is possible to have shared (not
exclusive) data which is only shared between files within the subvolume,
and which will be freed if the subvolume is deleted. And, of course, the
obvious problem that if you only count exclusive then no one is being
charged for all the shared segments ("Oh, my backup is getting a bit
expensive. Hmm. I know! I will back up all my files to two different
destinations, and make sure btrfs is sharing the data between both
locations! Then no one pays for it! Whoopee!")

In my opinion, the shared/exclusive information in btrfs fi du is worse
than useless: it confuses people who think it means something different
from what it does. And, in btrfs, it isn't really useful to know whether
something is "exclusive" or not -- what people care about is always
something else (which is dependent on **where** it is shared, and by whom).

The biggest problem is that you haven't defined what **you** (in your
particular use case) mean by the "size" of a subvolume. For btrfs that
doesn't have any single obvious definition.

Most commonly, I think, people mean "how much space on disk would be
freed up if I deleted this subvolume and all subvolumes contained within
it", although quite often they mean the similar (but not identical) "how
much space on disk would be freed up if I deleted just this subvolume".
And sometimes they actually mean "how much space on disk would be freed
up if I deleted this subvolume, the subvolumes contained with in, and
all the snapshots I have taken but are lying around forgotten about in
some other directory tree somewhere".

But often they mean something else completely, such as "how much space
is taken up by the data which was originally created in this subvolume
but which has been cloned into all sorts of places now and may not even
be referred to from this subvolume any more" (typically this is the case
if you want to charge the subvolume owner for the data usage).

And, of course, another reading of your question would be "how much data
was transferred during this send/receive operation" (relevant if you are
running a backup service and want to charge people by how much they are
sending to the service rather than the amount of data stored).

That is why I created my "extents-list" stuff. This is a horrible hack
(one day I will rewrite it using the python library) which lets me
answer questions like: "how much space am I wasting by keeping
historical snapshots", "how much data is being shared between two
subvolumes", "how much of the data in my latest snapshot is unique to
that snapshot" and "how much space would I actually free up if I removed
(just) these particular directories". None of which can be answered from
the existing btrfs command line tools (unless I have missed something).

> And it is pretty slow: on my backup disk (spinning rust, ~2000
> subvolumes, ~100 sharing data), btrfs fi du takes around 5min for a
> subvolume of 20GB, while btrfs find-new takes only seconds.

Yes. Answering the real questions involves taking the FIEMAP data for
every file involved (which, for some questions, is actually every file
on the disk!) so it takes a very long time. Days for my multi-terabyte
backup disk.

> Summing up, what I'm looking for would be something like:
> 
>   btrfs fi du -s --exclusive-relative-to=<other-subvol> <subvol>

You can do that with FIEMAP data. Feel free to look extents-lists. Also
feel free to shout "this is a gross hack" and scream at me!

If you really just need it for two subvols like that

extents-expr -s <subvol> - <other-subvol>

will tell you how much space is in extents used in <subvol> but not used
in <other-subvol>.

Graham
