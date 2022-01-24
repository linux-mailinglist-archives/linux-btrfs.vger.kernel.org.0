Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673B5499CC9
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jan 2022 23:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580155AbiAXWIy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jan 2022 17:08:54 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35926 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1576574AbiAXVzS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jan 2022 16:55:18 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 31704219A0;
        Mon, 24 Jan 2022 21:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643061316;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kxRLc5IW3KyuSVeIx5xBmn1HAGimHOo9kZw6BJ15PGk=;
        b=gjDJN0SZfItk0HjPY7qcWn/V15yvOFvpdm4ptb7oy9Z34QaCX3vYpyRf+1XkWVsUbKFxKV
        C3NjJY78SB/x9s8IMmQWrKbn9cYGoIoXrjH00EA6vHqC45rTAPhsCokoT8FYpN2Q9BeY7I
        nCvlP51NLgcr7aO1asF7GL+8BcjTGdY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643061316;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kxRLc5IW3KyuSVeIx5xBmn1HAGimHOo9kZw6BJ15PGk=;
        b=Vagr1n1XyevqcTElazMK4+xGsc38+4wi53b8rCWUu9chIhRtF/hYzxwG1nKqxjk9C7Q0CM
        CJ7r0D9m3PXdnDCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 24001A3B83;
        Mon, 24 Jan 2022 21:55:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 04BAADA7A9; Mon, 24 Jan 2022 22:54:35 +0100 (CET)
Date:   Mon, 24 Jan 2022 22:54:35 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v12 09/17] btrfs: add BTRFS_IOC_ENCODED_READ
Message-ID: <20220124215435.GK14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1637179348.git.osandov@fb.com>
 <111c7aadb3fa218b7926a49acf3fb34654d89a75.1637179348.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <111c7aadb3fa218b7926a49acf3fb34654d89a75.1637179348.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 17, 2021 at 12:19:19PM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>

> - We don't do read repair, because it turns out that read repair is
>   currently broken for compressed data.

Is there a reproducer, and a fix?
