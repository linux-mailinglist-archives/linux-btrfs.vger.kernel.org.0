Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB0EDF1A5
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 17:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfJUPeg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 11:34:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbfJUPeg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 11:34:36 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49CDF2089C;
        Mon, 21 Oct 2019 15:34:35 +0000 (UTC)
Date:   Mon, 21 Oct 2019 11:34:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH v3] tools/lib/traceevent, perf tools: Handle %pU format
 correctly
Message-ID: <20191021113433.1205fc73@gandalf.local.home>
In-Reply-To: <6bc13ae1-9f26-afaa-ddfa-f1dd1cdcf6df@gmx.com>
References: <20191021094730.57332-1-wqu@suse.com>
        <20191021095625.2dfe3359@gandalf.local.home>
        <3830b0c5-5b76-36c1-5e3a-64dad62f76fb@gmx.com>
        <20191021102408.3bb4aa8b@gandalf.local.home>
        <6bc13ae1-9f26-afaa-ddfa-f1dd1cdcf6df@gmx.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 21 Oct 2019 22:30:37 +0800
Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:

> > How do you read it in English?  
> 
> How about mathematics interval?
> 
> i in [1, 4].
> 
> It looks way easier and simpler no matter what language you speak.

But C doesn't accept that syntax ;-)

-- Steve
