Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2057D049C
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Oct 2023 00:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346633AbjJSWCb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Oct 2023 18:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346601AbjJSWCa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Oct 2023 18:02:30 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B39116
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 15:02:28 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c9daca2b85so1609145ad.1
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 15:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1697752948; x=1698357748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tePTsAOLSKNkXxpi1DoTK7cPVwy/xFqcvNRJj1WQpQs=;
        b=I0FNLpiU18se5kvNpe4QsjdhDDpne6tx46CXgQ76T5B2wlf12GH1YZMjxpUMtfLWYX
         qgSirZkSkj10KFyCfsXs1vXvds4xh1Ucxeqh2H19RwtzVczGaDnC6T3Vc33wvmhNlZ27
         UY4sHSnzATCZEPcg1FjxOGBGtVEk5r62s9LirQA5Y2Zd5kwRGT4akBIC42ekdXJyMQyu
         sqINhf09Ih4aWfm/GvKWf6S1vxX/phB/2Kp69/+BtDtrpg9KhMsoMg6zyjgLnRVpN6CW
         iMqsv0fgud+703tXf+ZlRfVmSKYmsCqautcJvdHtaqYO6n7wXPGzrS6tTMpM7LAMtNkH
         ADVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697752948; x=1698357748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tePTsAOLSKNkXxpi1DoTK7cPVwy/xFqcvNRJj1WQpQs=;
        b=W+xVcj4XLKHP8xdb2R9wvEU7q8Ajw4kXK+KSosSbMPeo6n1UmxIW4xG/5uF5IstlJ8
         QBN0+Kgdy8eV5E2pl0PTWLJF4QHt7MGUNCac52w05h+7qBC4jelqoshRkLsCL9D3fzS6
         wEmL6rMY1b8FbSWuVUx+P9Yujr/lWegI80yrc6eX0F+N0NFm+zw9VI/MD00C6TDVXbPp
         4h5tD4lkxYelePvfXvNbpW6Mau2YXLT0gvZS62iDA2pj7jNoaME5dK+eTX+Yr57sv2C1
         vXW6U0axg0eC+PBHkPpqVGFdLXbPs9KpsfiM8liyfIxPmg65L9Hy3R61uNNOwqsnXqDr
         VGtg==
X-Gm-Message-State: AOJu0YyV6x5ewa5LXhS3CCAqMkE2dFEV/N7IC/wlaUm7mZClM/l+S9QI
        EfojvnxtOw7ICQEb+S0fhoanww==
X-Google-Smtp-Source: AGHT+IGofu+MJKzCHfasjwiDGYCbXyVv9CGGJQIOinf95G43x5bHvvDHOMSsorB5TbxulBM699MT1g==
X-Received: by 2002:a17:903:2447:b0:1c5:ecfc:2650 with SMTP id l7-20020a170903244700b001c5ecfc2650mr4379861pls.14.1697752948177;
        Thu, 19 Oct 2023 15:02:28 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id ix4-20020a170902f80400b001bc5dc0cd75sm190994plb.180.2023.10.19.15.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 15:02:27 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qtb60-001JiA-2E;
        Fri, 20 Oct 2023 09:02:24 +1100
Date:   Fri, 20 Oct 2023 09:02:24 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
Message-ID: <ZTGncMVw19QVJzI6@dread.disaster.area>
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
 <20231018-mgtime-v1-2-4a7a97b1f482@kernel.org>
 <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
 <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
 <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
 <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
 <20231019-fluor-skifahren-ec74ceb6c63e@brauner>
 <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 19, 2023 at 07:28:48AM -0400, Jeff Layton wrote:
> On Thu, 2023-10-19 at 11:29 +0200, Christian Brauner wrote:
> > > Back to your earlier point though:
> > > 
> > > Is a global offset really a non-starter? I can see about doing something
> > > per-superblock, but ktime_get_mg_coarse_ts64 should be roughly as cheap
> > > as ktime_get_coarse_ts64. I don't see the downside there for the non-
> > > multigrain filesystems to call that.
> > 
> > I have to say that this doesn't excite me. This whole thing feels a bit
> > hackish. I think that a change version is the way more sane way to go.
> > 
> 
> What is it about this set that feels so much more hackish to you? Most
> of this set is pretty similar to what we had to revert. Is it just the
> timekeeper changes? Why do you feel those are a problem?
> 
> > > 
> > > On another note: maybe I need to put this behind a Kconfig option
> > > initially too?
> > 
> > So can we for a second consider not introducing fine-grained timestamps
> > at all. We let NFSv3 live with the cache problem it's been living with
> > forever.
> > 
> > And for NFSv4 we actually do introduce a proper i_version for all
> > filesystems that matter to it.
> > 
> > What filesystems exactly don't expose a proper i_version and what does
> > prevent them from adding one or fixing it?
> 
> Certainly we can drop this series altogether if that's the consensus.
> 
> The main exportable filesystem that doesn't have a suitable change
> counter now is XFS. Fixing it will require an on-disk format change to
> accommodate a new version counter that doesn't increment on atime
> updates. This is something the XFS folks were specifically looking to
> avoid, but maybe that's the simpler option.

And now we have travelled the full circle.

The problem NFS has with atime updates on XFS is a result of
the default behaviour of relatime - it *always* forces a persistent
atime update after mtime has changed. Hence a read-after-write
operation will trigger an atime update because atime is older than
mtime. This is what causes XFS to run a transaction (i.e. a
persistent atime update) and that bumps iversion.

lazytime does not behave this way - it delays all persistent
timestamp updates until the next persistent change or until the
lazytime aggregation period expires (24 hours). Hence with lazytime,
read-after-write operations do not trigger a persistent atime
update, and so XFS does not run a transaction to update atime. Hence
i_version does not get bumped, and NFS behaves as expected.

IOWs, what the NFS server actually wants from the filesytsems is for
lazy timestamp updates to always be used on read operations. It does
not want persistent timestamp updates that change on-disk state. The
recent "redefinition" of when i_version should change effectively
encodes this - i_version should only change when a persistent
metadata or data change is made that also changes [cm]time.

Hence the simple, in-memory solution to this problem is for NFS to
tell the filesysetms that it needs to using lazy (in-memory) atime
updates for the given operation rather than persistent atime updates.

We already need to modify how atime updates work for io_uring -
io_uring needs atime updates to be guaranteed non-blocking similar
to updating mtime in the write IO path. If a persistent timestamp
change needs to be run, then the timestamp update needs to return
-EAGAIN rather than (potentially) blocking so the entire operation
can be punted to a context that can block.

This requires control flags to be passed to the core atime handling
functions.  If a filesystem doesn't understand/support the flags, it
can just ignore it and do the update however it was going to do it.
It won't make anything work incorrectly, just might do something
that is not ideal.

With this new "non-blocking update only" flag for io_uring and a
new "non-persistent update only" flag for NFS, we have a very
similar conditional atime update requirements from two completely
independent in-kernel applications.

IOWs, this can be solved quite simply by having the -application-
define the persistence semantics of the operation being performed.
Add a RWF_LAZYTIME/IOCB_LAZYTIME flag for read IO that is being
issued from the nfs daemon (i.e. passed to vfs_iter_read()) and then
the vfs/filesystem can do exactly the right thing for the IO being
issued.

This is what io_uring does with IOCB_NOWAIT to tell the filesystems
that the IO must be non-blocking, and it's the key we already use
for non-blocking mtime updates and will use to trigger non-blocking
atime updates....

I also know of cases where a per-IO RWF_LAZYTIME flag would be
beneficial - large databases are already using lazytime mount
options so that their data IO doesn't take persistent mtime update
overhead hits on every write IO.....

> There is also bcachefs which I don't think has a change attr yet. They'd
> also likely need a on-disk format change, but hopefully that's a easier
> thing to do there since it's a brand new filesystem.

It's not a "brand new filesystem". It's been out there for quite a
long while, and it has many users that would be impacted by on-disk
format changes at this point in it's life. on-disk format changes
are a fairly major deal for filesystems, and if there is any way we
can avoid them we should.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
