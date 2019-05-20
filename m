Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5122419B
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2019 21:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfETT6Y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 20 May 2019 15:58:24 -0400
Received: from voltaic.bi-co.net ([134.119.3.22]:53446 "EHLO voltaic.bi-co.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfETT6Y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 May 2019 15:58:24 -0400
Received: from lass-mb.fritz.box (aftr-95-222-30-100.unity-media.net [95.222.30.100])
        by voltaic.bi-co.net (Postfix) with ESMTPSA id AC485209BD;
        Mon, 20 May 2019 21:58:21 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: fstrim discarding too many or wrong blocks on Linux 5.1, leading
 to data loss
From:   =?utf-8?Q?Michael_La=C3=9F?= <bevan@bi-co.net>
In-Reply-To: <ea5552b8-7b6a-2516-d968-c3f3c731e159@gmail.com>
Date:   Mon, 20 May 2019 21:58:20 +0200
Cc:     Andrea Gelmini <andrea.gelmini@gelma.net>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, dm-devel@redhat.com
Content-Transfer-Encoding: 8BIT
Message-Id: <A140375B-7C55-4D1D-8892-3C93E5F0E49F@bi-co.net>
References: <297da4cbe20235080205719805b08810@bi-co.net>
 <CAJCQCtR-uo9fgs66pBMEoYX_xAye=O-L8kiMwyAdFjPS5T4+CA@mail.gmail.com>
 <8C31D41C-9608-4A65-B543-8ABCC0B907A0@bi-co.net>
 <CAJCQCtTZWXUgUDh8vn0BFeEbAdKToDSVYYw4Q0bt0rECQr9nxQ@mail.gmail.com>
 <AD966642-1043-468D-BABF-8FC9AF514D36@bi-co.net>
 <158a3491-e4d2-d905-7f58-11a15bddcd70@gmx.com>
 <C1CD4646-E75D-4AAF-9CD6-B3AC32495FD3@bi-co.net>
 <CAK-xaQYPs62v971zm1McXw_FGzDmh_vpz3KLEbxzkmrsSgTfXw@mail.gmail.com>
 <9D4ECE0B-C9DD-4BAD-A764-9DE2FF2A10C7@bi-co.net>
 <CAK-xaQYakXcAbhfiH_VbqWkh+HBJD5N69ktnnA7OnWdhL6fDLA@mail.gmail.com>
 <ea5552b8-7b6a-2516-d968-c3f3c731e159@gmail.com>
To:     Milan Broz <gmazyland@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> Am 20.05.2019 um 18:45 schrieb Milan Broz <gmazyland@gmail.com>:
> 
> On 20/05/2019 16:53, Andrea Gelmini wrote:
> ...
>> Also, changing crypttab:
>> root@glet:~# cat /etc/crypttab
>> sda6_crypt UUID=fe03e2e6-b8b1-4672-8a3e-b536ac4e1539 none luks,discard
>> 
>> removing discard didn't solve the issue.
> 
> This is very strange, disabling discard should reject every discard IO
> on the dmcrypt layer. Are you sure it was really disabled?
> 
> Note, it is the root filesystem, so you have to regenerate initramfs
> to update crypttab inside it.

For me, I cannot reproduce the issue when I remove the discard option from the crypttab (and regenerate the initramfs). When trying fstrim I just get “the discard operation is not supported”, as I would expect. No damage is done to other logical volumes.

However, my stack differs from Andrea’s in that I have dm-crypt on an LVM logical volume and not dm-crypt as a physical volume for LVM. Not sure if that makes a difference here.

Cheers,
Michael

> Could you paste "dmsetup table" and "lsblk -D" to verify that discard flag
> is not there?
> (I mean dmsetup table with the zeroed key, as a default and safe output.)
> 
> Milan

