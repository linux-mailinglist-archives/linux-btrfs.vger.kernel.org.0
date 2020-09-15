Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7408826A09D
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 10:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgIOIWs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 04:22:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:36398 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgIOISw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 04:18:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8295BB195;
        Tue, 15 Sep 2020 08:18:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C5CB1DA818; Tue, 15 Sep 2020 10:17:25 +0200 (CEST)
Date:   Tue, 15 Sep 2020 10:17:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     A L <mail@lechevalier.se>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Changes in 5.8.x cause compsize/bees failure
Message-ID: <20200915081725.GH1791@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, A L <mail@lechevalier.se>,
        linux-btrfs@vger.kernel.org
References: <632b888d-a3c3-b085-cdf5-f9bb61017d92@lechevalier.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <632b888d-a3c3-b085-cdf5-f9bb61017d92@lechevalier.se>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 12, 2020 at 07:13:21PM +0200, A L wrote:
> I noticed that in (at least 5.8.6 and 5.8.8) there is some change in 
> Btrfs kernel code that cause them to fail.
> 
> For example compsize now often/usually fails with: "Regular extent's 
> header not 53 bytes (0) long?!?"
> 
> Bees is having plenty of errors too, and does not succeed to read any 
> files (hash db is always empty). Perhaps this is an unrelated problem?

The fix is now in stable queue, to be released in 5.8.10. Thanks for the
report!
