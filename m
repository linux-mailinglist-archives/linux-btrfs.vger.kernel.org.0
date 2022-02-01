Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E64D4A5DD9
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Feb 2022 15:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238837AbiBAODH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 09:03:07 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44202 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237314AbiBAODG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Feb 2022 09:03:06 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B43B321111;
        Tue,  1 Feb 2022 14:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643724185;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=syD8A+7qh8Josxz+ypCryFIjfPMAjtZutYqPqh7gJxk=;
        b=qVjxefFf/LokQXbg0eIY1MYqW1pPbnxjbRZFEDdErj2tcB+EDjspVaw/8lXz4KSobvRBo3
        LO0O7VcvUa/SiK/aXWqBMRY8kulp389qaL7pLjo9eQEKARtBZj87C+qXWDcsOg90YqiO1r
        +VkmWFRTf1bXCKzXrZ75W0GR4etm5cY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643724185;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=syD8A+7qh8Josxz+ypCryFIjfPMAjtZutYqPqh7gJxk=;
        b=QQPGBqkI+pCU+Bu6TvH55HYG1NQn9Rqp/Euk3RT8ZG0NXn73tWAd5UaKFXsSJSlNlrUnZa
        Me22w1jSo4Gw2QCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id AD200A3B84;
        Tue,  1 Feb 2022 14:03:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7C195DA7A9; Tue,  1 Feb 2022 15:02:21 +0100 (CET)
Date:   Tue, 1 Feb 2022 15:02:21 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, quwenruo.btrfs@gmx.com
Subject: Re: [PATCH] btrfs: qgroup: replace modifing qgroup_flags to bitops
Message-ID: <20220201140221.GN14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs@vger.kernel.org, quwenruo.btrfs@gmx.com
References: <20220201125331.260482-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201125331.260482-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 01, 2022 at 12:53:31PM +0000, Sidong Yang wrote:
> This patch replaces the code modifying or checking qgroup_flags to
> bitops like set_bit or test_bit. These bit operations works atomically
> that it protects qgroup_flags value.

Also please explain if this is fixing a problem or what's the reason for
the change (cleanup, preparatory work, ...).
