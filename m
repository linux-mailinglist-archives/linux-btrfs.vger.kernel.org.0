Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C5C350E7A
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Apr 2021 07:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbhDAFhL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Apr 2021 01:37:11 -0400
Received: from mout.gmx.net ([212.227.17.21]:43413 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229539AbhDAFhD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Apr 2021 01:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617255420;
        bh=GikQ9N/dtuGOaDe7mZQJrXN6q1NMiwBPiz+N1SkZQsU=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=aZyX1uZ17na7uLQ49rP0AEc8rW1STcpfoY5kVmZBGLVbQyC1ryK5jTGPEMogxliX6
         zdhLJtCzo70KsYpkeMHyS++NPcQL9cZwKsaEuLeTAQmH/1fUwRnlUf+uITQp6YR7Gu
         TQlpNQxHzW5iHN2fIi3DKH9VzOBnh77lcYHQYc+E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDQeU-1lIWbd2cNC-00AXs1; Thu, 01
 Apr 2021 07:37:00 +0200
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210325071445.90896-1-wqu@suse.com>
 <20210329185338.GV7604@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
Message-ID: <dc64f94d-52ad-9c36-534e-5a84bf449448@gmx.com>
Date:   Thu, 1 Apr 2021 13:36:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210329185338.GV7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AWIDfBNrWoiIpVNBdaeg86WfQF5GRH4h57wZN4x5u/PAX/69dzR
 vEiX68mvDXpmXPNS+tj7vXT7fOXz+Ob/mhFS8vPSe9xsTVVATOmLAzBGjJ07VHNkXJhRToW
 8hj6PWoOjXMe8P/tgxTOlkL1/ODU/KzTLVE4j16zz8tkT+wminTbCSowqyMxiwC3+3h0Kg0
 +498qE3TdLzuWK4lMcKlw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:erluoA3UAj0=:K8pW9S/rFpfg1OJkiefMW5
 9IXqk6rMuejKDw8Ojwv2T5Fg6XV1O4eIPed/lM8zxyw9/HMKG8M6yASiPhomCHrA06DYuvc07
 zJo0vPdE5QktuZXylEEbobIBIah+NsBz02T35tpvFiwip8YQVnFw5Mq8HAdamnfceor632zLR
 er3h2ntroznEgUps/FzJ6VIPThkROBS6ns6EiNjppB0cS2BKaE0xUC0duJ8oyGbLT1gGf/7Y+
 u+S7oh1xh5qJvTqVO2L5eyDPDSWWVoWGK5Tnw8kEBBW+FFIuGmxNM57OP4QKqCms6zS9cnAy2
 Jq82i4uDwjcsIf04haJWgVFsuZ62zTbDAIrUbiEW3cLzidBv7z7i8zBdsEol4HBpPJ4tuO672
 z5ARzYUbuYG/dD7t1zzAJsR6UQPlwHMc1pdKDtx0G2rEJWQsNqufdG8/HqT8Gj6gj7zaeKLg8
 77oPFtCdGGPsLP2GjEQFwn9j7rbbC2GhhwmMapmVj6sX4RDj8gPqtljgcJF8bD9lVnzfpkNGn
 iIMbVBQnTFeD5JGQ5CLyZ7zQgHA6upTvT56H56BsOLa2I4SW0FIoNB/Y3RvtF3UzJUvZeG2lO
 4Fh1HvLRDK6+1QUnEPHvG1E8kx0ybAWVojRY1Spx+JSS8yhGATZuMSsMU6Ige67qJ+P6GpM0y
 lHmYiMetR7FAqd487YCtWYg1DkFy+TIssZm3098z0yMD9BSx9xyUHoaR7IOoPskmvBwbnMqnz
 /C0ZxJp1uUpxugj9/njV5KqvvScDurbOPj623DJqZ/ClnCxASffK8lDMRjgAQ8xIfFmzJt80J
 m9gBUIfGsUUJrlAAOp+Yuf2D5RmyYRbU2ObtsFcWu/1pVHlVWTbXo94Ss7V2Wd/bZyJnV6JB6
 P4z2DjzKDDQ//4q9a/ugsRYg7It5KM/BBGd6cNkYskBC/vtfGlpQMZ13FbAonxJgeovg9W2GZ
 a7s2wd1kLDdJjQ4L8ZWsrhcpX84Bb+dax52Hwde5ACTrpj2xg6suvp1tN9tzXOTU+3vVY2oqX
 cgP9TrsrKKDgf7CeOXW3fVIJpIw7KXq6cetpt836OgfiJgecGr91FdJOlgJuRJr6/H5PXS5jL
 q3alwusGpL6l9XkGsik/rnzdPxwpBaopQF0t3zz682BRQzDgVN0RIBP55Wz6cnjmZYOyc6tzk
 MwXyiaWnN9IDQ4E2U5oeIVor5aoSGCEO1nluD0IVweLlWuxGiK2oEf4k1+z+ipj2CN269y7cv
 aeUf7o3je+JrELNUU
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/3/30 =E4=B8=8A=E5=8D=882:53, David Sterba wrote:
> On Thu, Mar 25, 2021 at 03:14:32PM +0800, Qu Wenruo wrote:
>> v3:
>> - Rename the sysfs to supported_sectorsizes
>>
>> - Rebased to latest misc-next branch
>>    This removes 2 cleanup patches.
>>
>> - Add new overview comment for subpage metadata
>
> V3 is now in for-next, targeting merge for 5.13. Please post any fixups
> as replies to the individual patches, I'll fold them in, rather a full
> series resend. Thanks.
>
Is it possible to drop patch "[PATCH v3 04/13] btrfs: refactor how we
iterate ordered extent in btrfs_invalidatepage()"?

Since in the series, there are no other patches touching it, dropping it
should not involve too much hassle.

The problem here is, how we handle ordered extent really belongs to the
data write path.

Furthermore, after all the data RW related testing, it turns out that
the ordered extent code has several problems:

- Separate indicators for ordered extent
   We use PagePriavte2 to indicate whether we have pending ordered extent
   io.
   But it is not properly integrated into ordered extent code, nor really
   properly documented.

- Complex call sites requirement
   For endio we don't care whether we finished the ordered extent, while
   for invalidatepage, we don't really need to bother if we finished all
   the ordered extents in the range.

   Thus we really don't need to bother who finished the ordered extents,
   but just want to mark the io finished for the range.

- Lack subpage compatibility
   That's why I'm here complaining, especially due to the PagePrivate2
   usage.
   It needs to be converted to a new bitmap.

There will be a refactor on the btrfs_dec_test_*_ordered_pending()
functions soon, and obvious the existing call sites will all be gone.

Thus that fourth patch makes no sense.

If needed, I can resend the patchset without that patch.

Thanks,
Qu
