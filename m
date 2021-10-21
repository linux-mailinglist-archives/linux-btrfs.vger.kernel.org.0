Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6334367C0
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 18:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhJUQbJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 12:31:09 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39842 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhJUQbI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 12:31:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 18C261FD58;
        Thu, 21 Oct 2021 16:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634833732;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KCa7X5kwaVl1F6bMYHYFvhk5QArlmWCYTqg0JZj/R0g=;
        b=h7SbXzCDfFjC7twTC/CFI5Rnklh6wqkKcTJDR1PL5s9+lH38iXkR3RjDTc6TyhMfS5T694
        eUyNnGOUrORdrSATQdRdZ7hkEaIBaW/hV3UhN6t8xgHQ2dscflGUnTKVVYLR9uJVfS8zdO
        7ohPhzsNIy5pVQhpLsjgk1U5Ym4WdiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634833732;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KCa7X5kwaVl1F6bMYHYFvhk5QArlmWCYTqg0JZj/R0g=;
        b=FQ/mOTE70QxZOxYTPjQqej2bCoWlnYAewxQjwAuxO78u9NbezXGTtbCR8Y8v/CgaCfa+od
        Wz2wud8Llu67CSDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 08C8BA3B89;
        Thu, 21 Oct 2021 16:28:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 39994DA7A3; Thu, 21 Oct 2021 18:28:23 +0200 (CEST)
Date:   Thu, 21 Oct 2021 18:28:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] btrfs: fix deadlock when defragging transparent huge
 pages
Message-ID: <20211021162823.GG20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <321ffae6065e36a6c698912a86f8019ea00f43b4.1634700835.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <321ffae6065e36a6c698912a86f8019ea00f43b4.1634700835.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 19, 2021 at 08:35:01PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> - Add comment to PageCompound() check. I didn't create a helper for it
>   because it's not clear what function to wrap. It could be
>   find_or_create_page(), find_lock_page(), or any other way we could get
>   a page cache page. So, if we end up needing it anywhere else, we can
>   create a common helper. For now, I think it's better to have an
>   explicit check rather than obscure it behind a one-off helper.

Ok, the comment is sufficient for now. Added to misc-next, thanks.
