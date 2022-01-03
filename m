Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCC64830B5
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jan 2022 12:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbiACLqK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jan 2022 06:46:10 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55368 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiACLqJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jan 2022 06:46:09 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C89C21F38B;
        Mon,  3 Jan 2022 11:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641210368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cia49DbHyxvuGFO7JCsFHHm3A1mWptU4tkfZB1J5a4M=;
        b=uXbJxgrzSPDp9rl/8NAtxfLeNekdd/0lBHLS5/u8oST3r8dlErCIgTHQHcunW+lp3hpeNR
        5wgwob/ihK9HnBt2fMF9D/cUpWibmmflwrl2kWbKC33em9uqasS5PR3AQ6dSWAFl7dF5Md
        eTgN+L6FnOulXwRSDj7BhS4/TwUpxHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641210368;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cia49DbHyxvuGFO7JCsFHHm3A1mWptU4tkfZB1J5a4M=;
        b=wQ7Rl2jE7AiS4PYgAdZHTZzxYasJYmQBiYOuwZsxX3IuuzsiJb+tAWMFGoeAn9r1kN2emm
        80G+mnYAE+A4S0AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB9DE13A88;
        Mon,  3 Jan 2022 11:46:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /86IKADi0mHgDQAAMHmgww
        (envelope-from <ddiss@suse.de>); Mon, 03 Jan 2022 11:46:08 +0000
Date:   Mon, 3 Jan 2022 12:46:07 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Eric Levy <contact@ericlevy.name>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: "hardware-assisted zeroing"
Message-ID: <20220103124607.524882f8@suse.de>
In-Reply-To: <2c80ca8507181b1e65a67bbd4dca459d24a47da2.camel@ericlevy.name>
References: <2c80ca8507181b1e65a67bbd4dca459d24a47da2.camel@ericlevy.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 03 Jan 2022 06:08:46 -0500, Eric Levy wrote:

> I am operating a Btrfs file system on logical volumes provided through
> an iSCSI target. The software managing the volumes shows that they are
> configured for certain features, which include "hardware-assisted
> zeroing" and "space reclamation". Presumably the meaning of these
> features, at least the former, is that a file system, with support of
> the kernel, may issue a SCSI command indicating that a region of a
> block device would be cleared. For a file system, such an operation has
> no direct value, because the contents of de-allocated space is
> irrelevant, but for a logical volume, it creates an opportunity to free
> space on the underlying file system on the back end.
> 
> I have searched the term "hardware-assisted zeroing", without finding
> any useful resources on the application of the term.

"hardware-assisted zeroing" is often marketing speak for the WRITE SAME
SCSI command, which is used by VMFS. I'm not aware of any Linux
filesystems which make use of it.

As Qu mentioned, "space reclamation" would refer to UNMAP / discard.

Cheers, David
