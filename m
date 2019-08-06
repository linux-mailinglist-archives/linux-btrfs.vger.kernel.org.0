Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26A048374D
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2019 18:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387743AbfHFQsn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Aug 2019 12:48:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:52670 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728927AbfHFQsn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 6 Aug 2019 12:48:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 894A2AEB3;
        Tue,  6 Aug 2019 16:48:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 76281DA7D7; Tue,  6 Aug 2019 18:49:14 +0200 (CEST)
Date:   Tue, 6 Aug 2019 18:49:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Hans van Kranenburg <hans@knorrie.org>
Cc:     linux-btrfs@vger.kernel.org,
        Hans van Kranenburg <hans.van.kranenburg@mendix.com>
Subject: Re: [PATCH] btrfs-progs: docs: fix label property description
Message-ID: <20190806164913.GO28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Hans van Kranenburg <hans@knorrie.org>,
        linux-btrfs@vger.kernel.org,
        Hans van Kranenburg <hans.van.kranenburg@mendix.com>
References: <20190803214403.1040-1-hans@knorrie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190803214403.1040-1-hans@knorrie.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Aug 03, 2019 at 11:44:03PM +0200, Hans van Kranenburg wrote:
> From: Hans van Kranenburg <hans.van.kranenburg@mendix.com>
> 
> Recently, commit c9da5695b2 improved the description for the label
> property, to clarify it's a filesystem property, and not a device
> property. Follow this change in the man page for btrfs-property.
> 
> Also add a little hint about what to specify as object.
> 
> Signed-off-by: Hans van Kranenburg <hans.van.kranenburg@mendix.com>

Applied, thanks.
