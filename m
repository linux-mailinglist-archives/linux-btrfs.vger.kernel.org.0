Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDF80A6CEB
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2019 17:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbfICPeO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Sep 2019 11:34:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:54212 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725782AbfICPeO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Sep 2019 11:34:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 67496B0BE;
        Tue,  3 Sep 2019 15:34:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EB328DA876; Tue,  3 Sep 2019 17:34:29 +0200 (CEST)
Date:   Tue, 3 Sep 2019 17:34:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: docbook45 is gone
Message-ID: <20190903153429.GD2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Adam Borowski <kilobyte@angband.pl>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20190903081704.GA6277@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903081704.GA6277@angband.pl>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 03, 2019 at 10:17:04AM +0200, Adam Borowski wrote:
> I'm afraid that asciidoctor 2.0 dropped support for docbook45.  The
> explanation given is here:
> https://github.com/asciidoctor/asciidoctor/issues/3005
> 
> This makes btrfs-progs fail to build unless docs are off, with:
> asciidoctor: FAILED: missing converter for backend 'docbook45'. Processing aborted.
> 
> Naively bumping the backend to docbook5 makes the output fail to pass
> validation.

As a workaround you can do

XMLTO_EXTRA += --skip-validation

it builds and the result looks correct from the few samples I tried.
Proper conversion to docbook5 will need to happen anyway, I'll open an
issue for 5.3 target. Thanks for the report.
