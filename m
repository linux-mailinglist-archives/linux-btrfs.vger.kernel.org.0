Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367A13461D9
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Mar 2021 15:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhCWOud (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Mar 2021 10:50:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:60262 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232370AbhCWOuW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Mar 2021 10:50:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7FA21ADAA;
        Tue, 23 Mar 2021 14:50:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 98C27DA7AE; Tue, 23 Mar 2021 15:48:16 +0100 (CET)
Date:   Tue, 23 Mar 2021 15:48:16 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: qgroup: remove outdated comment
Message-ID: <20210323144816.GG7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20210322140316.384012-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322140316.384012-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 22, 2021 at 02:03:16PM +0000, Sidong Yang wrote:
> This comment is outdated and this patch remove
> it to avoid confusion.

Even if it's just a comment removal, changelog should say why it's
outated, I have no idea and would have to do the research myself.
