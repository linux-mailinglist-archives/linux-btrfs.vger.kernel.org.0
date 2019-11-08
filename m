Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5773FF3C91
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2019 01:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfKHAIl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Nov 2019 19:08:41 -0500
Received: from devico.uberspace.de ([185.26.156.185]:46128 "EHLO
        devico.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfKHAIk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Nov 2019 19:08:40 -0500
Received: (qmail 26317 invoked from network); 8 Nov 2019 00:08:37 -0000
Received: from unknown (HELO localhost) (2003:f9:f716:5d00:127b:44ff:fe50:1c77)
  by devico.uberspace.de with SMTP; 8 Nov 2019 00:08:37 -0000
From:   Leonard Lausen <leonard@lausen.nl>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: __btrfs_free_extent error after suspend resume
In-Reply-To: <7d16efdd-f6f9-9580-d361-a00251b6634c@gmx.com>
References: <878sotrhyi.fsf@lausen.nl> <87blto1lwx.fsf@lausen.nl>
 <7d16efdd-f6f9-9580-d361-a00251b6634c@gmx.com>
Date:   Fri, 08 Nov 2019 00:08:33 +0000
Message-ID: <87o8xnw7pa.fsf@lausen.nl>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo <quwenruo.btrfs@gmx.com> writes:
>>     btrfs check --readonly /dev/$NAME
>> 
>> runs out of 16GB of memory within 20 seconds and is killed by the
>> kernel.
>
> That's why we have btrfs check --mode=lowmem

Thank you for pointing this out Qu.
btrfs check --mode=lowmem finds

checksum verify failed on 1383731085312 found 000000CC wanted FFFFFFF5
checksum verify failed on 1383731085312 found 000000CC wanted FFFFFFF5
bad tree block 1383731085312, bytenr mismatch, want=1383731085312, have=15281531241332003907
ERROR: shared extent 1776065458176 referencer lost (parent: 1383731085312)
ERROR: errors found in extent allocation tree or chunk allocation

When creating a backup of the home directory after the filesystem was
mounted ro, only a single log file could not be included in the backup
due to failure to read it.

Is there any way to fix the filesystem, given that btrfs check
--mode=lowmem does not support --repair?

Do you think this corruption is related to some kernel bug, triggered
during suspend / resume cycle? Or could it be simply a harddrive (SSD)
failure? (An extended disk self test did not report any errors though.)

Best regards
Leonard
