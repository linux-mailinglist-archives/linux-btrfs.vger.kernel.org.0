Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76D73FB461
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 13:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbhH3LJp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 07:09:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48370 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbhH3LJo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 07:09:44 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9FA9E1FDE6;
        Mon, 30 Aug 2021 11:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630321729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eHOw/+GeawCEHuWE5PUDVfwlcwDqaDygN2qHsvURshU=;
        b=ETW74TYJVeFDLyT0l34OUVj7HlJATile/uZ/qnX6yAMz+7umpCR8NVcTvLwdpqJur+CxXW
        UVBG0V+hMU21w1sD5lIYFXCgDj64MkKcvlf0OUB/t7OjxemGMabPXgEn6RcBhORXW6MAJk
        LIWj1ZQAk1DgkJk82V/jGa42nul3NCU=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6600D13698;
        Mon, 30 Aug 2021 11:08:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id eQ2qFUG8LGE3UAAAGKfGzw
        (envelope-from <nborisov@suse.com>); Mon, 30 Aug 2021 11:08:49 +0000
Subject: Re: [PATCH] btrfs: Add test for rename exchange behavior between
 subvolumes
To:     fdmanana@gmail.com
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210819131456.304721-1-nborisov@suse.com>
 <CAL3q7H57NsQ2WhdsC3=gYftFp_JUKHVxNgCAQuXPwvFzux9CaA@mail.gmail.com>
 <b49f409f-e5cc-6d13-ef6a-2ab25f95d19e@suse.com>
 <CAL3q7H7WyC9LQXJYYe9DCTPPiL-Q1P_gyNGptEBMH=2br5dE-g@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <9f83250b-db93-bdf8-5288-0259afdf725b@suse.com>
Date:   Mon, 30 Aug 2021 14:08:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H7WyC9LQXJYYe9DCTPPiL-Q1P_gyNGptEBMH=2br5dE-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30.08.21 г. 13:56, Filipe Manana wrote:
> On Mon, Aug 30, 2021 at 8:18 AM Nikolay Borisov <nborisov@suse.com> wrote:
>>
>>
>>
>> <snip>
>>> Finally, this would also be a good opportunity to test regular renames
>>> with subvolumes too, as we had bugs and regressions in the past like
>>> in commit 4871c1588f92c6c13f4713a7009f25f217055807 ("Btrfs: use right
>>> root when checking for hash collision
>>> "), and never got any test cases for them.
>>
>> What specific tests do you have in mind? Ordinary renames of files
>> within a subvolume are already tested by merit of generic geneirc/02[345].
> 
> So besides the case mentioned in that patch's changelog (renaming a
> subvolume), checking that we can't rename an inode across subvolumes.
> Something like checking that:
> 
> rename /mnt/subvol1/file /mnt/subvol2/file
> 
> fails with -EXDEV.

But this is already checked by merit of using this line:

_rename_tests_source_dest $SCRATCH_MNT/subvol1/src
$SCRATCH_MNT/subvol2/dst "cross-subvol" "-x"


it tests multiple combinations of regular/symbolic/directory/dev/null
pairs. I.e :

cross-subvol regu/regu -> Invalid cross-device link



So this is already covered I'd say. Or you mean to test those
combinations even without rename exchange, which would boil down to
calling _rename_tests_source_dest without the -x flag.

> 
> Thanks.
> 
> 
>>
>> The test in the patch you cited is basically renaming a subvolume within
>> the same subvolume, that's easy enough.
>>
>> <snip>
> 
> 
> 
