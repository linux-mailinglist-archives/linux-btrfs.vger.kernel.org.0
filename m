Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49CBAE078A
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 17:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732450AbfJVPfK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 11:35:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:43452 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732384AbfJVPfJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 11:35:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2323BAC10;
        Tue, 22 Oct 2019 15:35:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D1F87DA732; Tue, 22 Oct 2019 17:35:18 +0200 (CEST)
Date:   Tue, 22 Oct 2019 17:35:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs fixes for 5.4-rc5
Message-ID: <20191022153514.GZ3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        torvalds@linux-foundation.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1571751313.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571751313.git.dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 22, 2019 at 03:52:07PM +0200, David Sterba wrote:
> * fix during file sync, the full-sync status might get dropped
>   externally, eg. by background witeback under some circumstances

Please replace the above merge log entry with

* fix race when handling full sync flag

The above wording was wrong and misleading, the changelog has all the
deatils and my attempt to condense it did not work very well. Thanks.
