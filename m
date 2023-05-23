Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C8970DB0D
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 13:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjEWLAP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 07:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjEWLAN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 07:00:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CD112B
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 04:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1684839606; i=quwenruo.btrfs@gmx.com;
        bh=L5uNdUYSsXJWgPHkHMm6zxRyt4Nd9mb/pLpxRCwkhZI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=mp2DBpbQ9DTLsOmG81h67uAN4n5bAxsO1/3zuM9TNr7X2SLiemSq+Euf2Qs5HHRDw
         D+6Jaf9cI3yqew6t9qBAyxmqFkmqFuJfOWQMXyzKusbuu51F024UVJ3U80CyVHt/P+
         dplXud5qnNPJzfnAV4oBpK2y+dR5UKq7mqbUddZjV9+gjbrnwQFztf5zeEgafH4bL4
         Vq3OVLmlMYfoyxVgO2J5DMRiRWhsK7qondIOPG0sJ9UFyDfogshDqAoRnHUROFd7g5
         jf3bsG26rY/zlbi3L1fklXbqIY6JA91VQ7sdRne7A/AvDCekZY8/TR9jHkp7C1AI6o
         w7HXOzjP0zDCQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuUjC-1qJUpT1jL0-00rYwD; Tue, 23
 May 2023 13:00:06 +0200
Message-ID: <6788dee4-aa48-e36c-9940-6298a6b82cd5@gmx.com>
Date:   Tue, 23 May 2023 19:00:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 0/2] btrfs-progs: tune: fix the leftover csum change item
 and add a test case for it
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1684802060.git.wqu@suse.com>
 <20230523104648.GW32559@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230523104648.GW32559@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZdigChQIWuR8WA2QCH8MEYUtroevxvUHsfm7c/yeHfq3PKDEZf6
 C1IU+wmWG182pnuqr7oF1qga8PvHIxKxX8tCE91a60kiAOEa1gVnqfn/tUStYPmIZeeoSMf
 5NFf+9Dfp6WV/FV/D6p0pY2jEE1v2i48EX0laOCXCZbGhWlFTyM2N+lrzZbnVdjZUgY43Ye
 RCelAbv/vpuOTJALxOsow==
UI-OutboundReport: notjunk:1;M01:P0:GhZ8B+devQU=;AHViybKJPSNW/I5yb79tURHy/bp
 lTc2V6KZxSvQMSOuLC/2hNrQ19M+fHHnpc3QwKAoIEZ1u9ANT0KjcN2BFcegfzn9C0L2wVatT
 5GAAL+znXmjLZxQ52FM5sW98eoTvlvK3fNsHF0IqY18D9HOVJo7CDeYYIzrmjubpZTWYDq2Ps
 q43LkIQBDO73Ad6wV7a/m4Kfn+SJHrcrPPIJdtP2RPvkbybBIXdOkUqcX5nX7Dg+1tyT0yUjM
 wiyFh4qx1u2rYpl5g1G1mPf49gWJrAehFH3P4XmLb096dYy1o+IlndIEj76fJRruod6MnWPfE
 R6Q61i/Ll3cPhSh7zL2+DpVgoUczYiTudVu46IQ6XconVPK5pvtYejT6RsSBwwcthnVeqz2SB
 PGmgnT0IaRZwwjUqZaQfTJ6oD+GuBfY3NtTJR450rIizDrOgmxv2wgwL7SiFKA/zTMFg2etpw
 11Nc9NLhFENXOiofXT1voHxoHuuBYjpsOgakNDDVPn9e991EyUkiOI8OPEd7wZqBPxR5O8A36
 gzBbIrUo+v0qaJMYDX2/p3iYXqQ8vI2mLCiBUcJ6N1bkM+td748dNaLSmWWhcYyCo7vhKf5aY
 vW4t39AaKWCf/nsVYCsiDL4uPaMkJulr/lf57S9IonwPIXRuCGLNzx73wEu8wcpukDxvDdkFS
 LtWriCbwR1XofHpF4ugJ06zpw1zypSndSu69Slozxu6EvjyjXr+LHOAt9ToZnbIiY7ZkB2qP/
 AZotY/HwGctHTOkAo17587hav0ju78mVd1vVcwR5e4CeSg0jdP+iESTEpNT8s/hmRqgpisSzS
 ++JxVy4V0Zoztepx4TtuA/CfUcmhVx6rNs/X1yGasPoy1THPM5nMglFelyLjjhXc/A11/0nf8
 h58lY+w2oHVRlswpsfeDyu+JpX9CwaqWLq084zHVPEcEHUs5teqAU4lE+MKZ3njIEKqhxfkvd
 ewzITzKnmB5MrOOYMf+s1CzHSjc=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/23 18:46, David Sterba wrote:
> On Tue, May 23, 2023 at 08:37:11AM +0800, Qu Wenruo wrote:
>> David's cyclic csum change tests exposed a bug even with the latest csu=
m
>> change code, that I'm a total idiot and forgot to delete the csum chang=
e
>> item.
>>
>> This results a bug that if we have run multiple csum changes to the sam=
e
>> target csum type (e.g. CRC32C->SHA256->CRC32C->SHA256), the second
>> conversion to the same type would fail due to the left over csum change=
 items.
>>
>> This series would do the fix and add a test case to cover this bug.
>>
>> Qu Wenruo (2):
>>    btrfs-progs: tune: delete the csum change item after converting the =
fs
>>    btrfs-progs: tests/misc: add a test case for csum change
>
> Added to devel thanks, no more errors reported.

Finally I can work on the resume part (which is not much compared to the
main workflow).

Thanks,
Qu
