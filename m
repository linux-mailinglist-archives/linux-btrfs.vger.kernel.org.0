Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2172D4205C8
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Oct 2021 08:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbhJDGWI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 02:22:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54800 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhJDGWI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Oct 2021 02:22:08 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A74D31FDCB;
        Mon,  4 Oct 2021 06:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633328418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HTksu0A1UQZP3D+5JTy4dKR0KnRaQZ2tGgPjg/+cGpI=;
        b=h/nsk7MbYM12Xi25HcUKdOj4PksS3Aw05OSxg97oxrfjIObl+FGtBzwut1Wxt+O1S+TxZ3
        Y30qiVhbyf4lgqEDMa//rcTm/W80t2dpIxTz0J2WPI9qVw4EuCt33JFTSIdnpKhG4fh773
        /dpQnQeiSD5gfwPycr40R9z4gECWYmY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B716139C1;
        Mon,  4 Oct 2021 06:20:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id d2PTGiKdWmFSXgAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 04 Oct 2021 06:20:18 +0000
Subject: Re: Changing the checksum algorithm on an existing BTRFS filesystem
To:     Matthew Warren <matthewwarren101010@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CA+H1V9wsz2y21qxaYAkNa2PuBUCnM4yFVpoSC5rGav-1LHdwHA@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <67b3a02c-ce3c-cd1a-a4b5-e79d7c8dcf5a@suse.com>
Date:   Mon, 4 Oct 2021 09:20:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CA+H1V9wsz2y21qxaYAkNa2PuBUCnM4yFVpoSC5rGav-1LHdwHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4.10.21 г. 8:26, Matthew Warren wrote:
> Is there currently any way to change the checksum used by btrfs
> without recreating the filesystem and copying data to the new fs?

No
