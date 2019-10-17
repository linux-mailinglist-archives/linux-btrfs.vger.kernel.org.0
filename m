Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBEEDAB0B
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 13:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439664AbfJQLR4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Oct 2019 07:17:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:46252 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439661AbfJQLR4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Oct 2019 07:17:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9D88AB188;
        Thu, 17 Oct 2019 11:17:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5F0E3DA808; Thu, 17 Oct 2019 13:18:05 +0200 (CEST)
Date:   Thu, 17 Oct 2019 13:18:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Merlin =?iso-8859-1?Q?B=FCge?= <merlin.buege@tuhh.de>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: small fixes/cleanup in Documentation
Message-ID: <20191017111805.GE2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Merlin =?iso-8859-1?Q?B=FCge?= <merlin.buege@tuhh.de>,
        linux-btrfs@vger.kernel.org
References: <20191017045006.130378-1-merlin.buege@tuhh.de>
 <1201273d-8051-b65a-51bc-6e4c12cff7f2@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1201273d-8051-b65a-51bc-6e4c12cff7f2@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 17, 2019 at 09:29:43AM +0300, Nikolay Borisov wrote:
> 
> 
> On 17.10.19 г. 7:50 ч., Merlin Büge  wrote:
> > The removed paragraph in btrfs-man5.asciidoc says the same as the
> > previous one.
> 
> This patch cannot be applied without an SOB line. Otherwise the changes
> look good.

Well, for documentation patches and for progs it's not that strict and
I've applied many drive-by patches. My sign-off will be there and the
original author is usually mentioned as Author:, so the credit is
recorded.
