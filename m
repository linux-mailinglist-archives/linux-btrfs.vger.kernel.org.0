Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4887422C3A
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 17:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhJEPWX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 11:22:23 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36964 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235490AbhJEPWW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 11:22:22 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1D7911FE76;
        Tue,  5 Oct 2021 15:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633447231;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KcD80jWE+PGmwWqx8fah+S3K/8jeTF2tRJafaIu8Xa8=;
        b=yf3ooSGOu250sPlXs/fyWZZYIUr8ZU0mjhhboompkLpEAY8B3MfUcRAd7aQLaemDU3Ek2x
        nV1rVxQwZW0H6RyA+xS2O5bGFC54qUFUFQA/xERvd+g1y6BtDrozyhmtEiAv+XED+e2Si3
        m8zsflZdNtaGSeQJq33yo5GK5XNlUpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633447231;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KcD80jWE+PGmwWqx8fah+S3K/8jeTF2tRJafaIu8Xa8=;
        b=H6+I6pOondfcfenomRxS0RO1EIn6ECTJcxrBOemasnaW4f8Zt7nlD+kXMioTxqRrJvpp4P
        PW3A+Jr1JpNEr0Cw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 16D74A3B88;
        Tue,  5 Oct 2021 15:20:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 49EDFDA7F3; Tue,  5 Oct 2021 17:20:11 +0200 (CEST)
Date:   Tue, 5 Oct 2021 17:20:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: fix comments in cmd_filesystem_show
Message-ID: <20211005152011.GF9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <4a67a664fc39059bbd566d4bce7eaf2471efd9ce.1632972069.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a67a664fc39059bbd566d4bce7eaf2471efd9ce.1632972069.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 30, 2021 at 08:18:55PM +0800, Anand Jain wrote:
> I had to go back to find what BTRFS_ARG_REG is, add a comment for that.
> 
> And, search_umounted_fs_uuids() is also to find the seed device, so bring
> the related comment above it.
> 
> No functional changes.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to devel, thanks.
