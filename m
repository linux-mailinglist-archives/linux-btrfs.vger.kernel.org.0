Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080675AE974
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Sep 2022 15:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbiIFNZ5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Sep 2022 09:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiIFNZ4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Sep 2022 09:25:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD969599
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Sep 2022 06:25:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 822321F9EF;
        Tue,  6 Sep 2022 13:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662470754;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/hyQH9Z5ZnVlTOvagMGJZKGLwII58kVN4rsURNgADAI=;
        b=Npt0akf+wlKrKhzN7pDhRP9dwMBZlirJuqTonI+MAEgFPZjwAxcpXCp7FCsaSP/f+IxD0k
        dT/oI9mK6LKjyRSzsMOHomD8P5Aol0RyUHYT1gjTYIaJfSIp4Z7965qMlqOZCRT9FJlvjZ
        RnEUJmAUaQJ9IwsErImcGVaEzISrBO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662470754;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/hyQH9Z5ZnVlTOvagMGJZKGLwII58kVN4rsURNgADAI=;
        b=VuHDx1s7xp9l615/c92DPg7uSuV4eipvLEkkY9hO0VMVG8U473qYNVrj8dxkq0G7OMmmHV
        Zfu6+RLh0KUbUeCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 58A2B13A19;
        Tue,  6 Sep 2022 13:25:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7nrEFGJKF2OzXgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 06 Sep 2022 13:25:54 +0000
Date:   Tue, 6 Sep 2022 15:20:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Alon Ben Refael <alon.ben.refael@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Feature suggestion for the btrfs
Message-ID: <20220906132031.GN13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CADm1Te+nXM2diJMj-jCTw7MKtS0uZEY8Qy8p+Twh4cCOxz+crw@mail.gmail.com>
 <CADm1TeKaCqt3ZHFhhZDZURaxsmTgsn7+WPKJVURtGkM4T09Npw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADm1TeKaCqt3ZHFhhZDZURaxsmTgsn7+WPKJVURtGkM4T09Npw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 06, 2022 at 12:35:01PM +0300, Alon Ben Refael wrote:
> Hello,
> 
> I have a suggestion for a feature for btrfs. I hope that this is the
> right way to go about suggesting it.
> So it goes like this:
> During a snapshot process, perform a check for whether or not the
> snapshot file is archived.

How and where is this information tracked? This sounds like a task for a
separate tool that scans the snapshot after creation.

> If there are more than a predetermined
> threshold a log warning is issued containing a list of said files and
> the date of modification.

The kernel log is not a good place to report this information, the
messages can get lost or rotated away before anything sees them.

> The idea of this is to be able to recognize the existence of
> rensomware on a user's computer, causing havoc on the file server. By
> doing so the infected machine can be wiped with as little data loss
> possible.

Aren't there specialized tools for that? I'm not sure filesystem should
do all the work, but yes it could provide features on which it can be
built. The snapshot is designed to be very fast and requires only
handful of blocks to be created and updated, anything that would need to
traverse the whole file hierarchy, especially in some context in kernel
suggests it's not the right way to me.
