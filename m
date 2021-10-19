Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A014333F7
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 12:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbhJSKyP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 06:54:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52390 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbhJSKyP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 06:54:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B5F21219D0;
        Tue, 19 Oct 2021 10:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634640721;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1YDPZu4/2Sj01J5O4PV2qrNKwuCkyXHHpI20gJyjP+g=;
        b=Pm+RUCBs600nzpD2CE0vwMOkl51qXCd8O4/E+mqbCNXn9iVYEQzxSwgkysq99PK6bc4Djl
        ss/uL+CUBDlpe8BJkwoTLs5HeAa2kEV+M4kvgBFHZsfSytFNPTxBHbGiZbtpFIKyc5mW02
        EmVTYTD5/Q/oGuGe1xGSPhX/9Ielj1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634640721;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1YDPZu4/2Sj01J5O4PV2qrNKwuCkyXHHpI20gJyjP+g=;
        b=s9CLG1qDWljChwU5uAmUpupx8TBOuCoWdQLx66OQOgPr4NLLTKlZLeXIswsxru8FjBiKUB
        XJ+C66dZKAYCXVDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id AEEAFA3B91;
        Tue, 19 Oct 2021 10:52:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 37C4EDA7A3; Tue, 19 Oct 2021 12:51:34 +0200 (CEST)
Date:   Tue, 19 Oct 2021 12:51:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        nborisov@suse.com
Subject: Re: [PATCH RFC] btrfs: send: v2 protocol and example OTIME changes
Message-ID: <20211019105133.GQ30611@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        nborisov@suse.com
References: <20211018144109.18442-1-dsterba@suse.com>
 <YW3moPgbBMQhN7XY@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW3moPgbBMQhN7XY@relinquished.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 18, 2021 at 02:26:56PM -0700, Omar Sandoval wrote:
> On Mon, Oct 18, 2021 at 04:41:09PM +0200, David Sterba wrote:
> > - set __BTRFS_SEND_C_MAX_V1 to the last command of the version or one
> >   beyond?
> > - drop UTIMES2 before release?
> > - naming?
> 
> If I'm understanding correctly, the main difference between this send
> stream v2 and mine is the BTRFS_SEND_FLAG_VERSION flag and
> btrfs_ioctl_send_args::version rather than my BTRFS_SEND_FLAG_STREAM_V2?
> That's definitely a better way to do it.

Yesh, I think we should track an integer in it's own value, this would
allow us to do more updates in the future once new features appear.
The protocol version is level of stream command compatibility, while the
flags are for mode of operation (no data, encoded, ...).

> What's your plan for merging this? Did you want to do this as a "trial
> run" before merging the compressed send/receive stuff as protocol v3, or
> did you want me to integrate these changes?

The ioctl update and versioned protocol support code can be merged to
5.16 queue, as we all seem to agree. To have something material in the
protocol the otime can be there too, enough to test the whole usecase,
without risk of getting it wrong.

V3 and following can be a bigger update, with enough time for testing.
With the versioned protocol we can do (as the worst case) one version
per release but hopefully we'll get all the current pending commands
into one version.
