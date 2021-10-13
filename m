Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA0B42BB46
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 11:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238900AbhJMJRk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 05:17:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43542 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbhJMJRj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 05:17:39 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 83EE52229D;
        Wed, 13 Oct 2021 09:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634116535;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JG70e5SukAID/AiR04msdhL0Fjz/DylYX7nHHHo6Mls=;
        b=RDd0c3B2GGHFBgj+YtysnbwekDjx6Qye54mRmxbFobXYgX9RB81DnSCRbrUUUvuD5vhu6f
        jStnqpjl+CF9DKsOaMLz7lLswEwXOWWFcX748a0KJRXAZQi6eNm80wX0u0zbprDTmyNQqj
        dTM30yMf0cThovnQVTi5WXv3ujZBpIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634116535;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JG70e5SukAID/AiR04msdhL0Fjz/DylYX7nHHHo6Mls=;
        b=xiNeshJwq5pchnSQbvJTgf7I9IMqr5ArDIfLzfEbMCPrLgYFRkBW48Hud/lzJBEkmy+w2U
        JAoNRYz6HwzBY6Dg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7B5A2A3B84;
        Wed, 13 Oct 2021 09:15:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4E40DDA7A3; Wed, 13 Oct 2021 11:15:11 +0200 (CEST)
Date:   Wed, 13 Oct 2021 11:15:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH] btrfs: reduce btrfs_update_block_group alloc argument to
 bool
Message-ID: <20211013091511.GZ9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <5f0f20b2b0ad9c608357f5f3db27c8e5a9714f80.1634104229.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f0f20b2b0ad9c608357f5f3db27c8e5a9714f80.1634104229.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 13, 2021 at 02:05:14PM +0800, Anand Jain wrote:
> btrfs_update_block_group() accounts for the number of bytes allocated or
> freed. Argument %alloc specifies whether the call is for alloc or free.
> Convert the argument %alloc type from int to bool.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to misc-next, thanks.
