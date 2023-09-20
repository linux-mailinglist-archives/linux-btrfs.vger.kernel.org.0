Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA347A8645
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Sep 2023 16:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbjITOMS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Sep 2023 10:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbjITOMR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Sep 2023 10:12:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE59AD;
        Wed, 20 Sep 2023 07:12:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC577C433C7;
        Wed, 20 Sep 2023 14:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695219131;
        bh=4g0uOk8VBf1uS75R3xOmF3VYJZplWwaP5KLfTlgZo2s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BENAfEB/HgQmzD5fI+RYaDQKDw2xSO1A8gbs1mzNEAHZ5eF8Mrg+6+5ditzXbNu5p
         pJHpwniOJZIpzKCEwFQ09IJaAHI7KYgRKjCiMQRUtr4BdK4vCfNSLf6m1g3NIG7Bw2
         t18SQAAwoEYSiyBR9LIAUbvAdpXSkrsXjXrkCLr8mBWZQuFbW6PsG9s7WcFHD8kdyJ
         03cq+sqpDgP8w5cLlAdzE9yzPnkbAPMB5ds0dQ0he+hsuib1kWK9O/1OH5JLJOL14v
         Bz5P7t1MhdAWiT9KOpNZ1oU51CzNnamG4hM2zLClIkwQAUTtJF6gIvJ3kqYSLPkijU
         /Ijv/Gjrhoy5g==
Message-ID: <ca82af4d6a72d7f83223c0ddd74fd9f7bcfa96b1.camel@kernel.org>
Subject: Re: [PATCH v7 12/13] ext4: switch to multigrain timestamps
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Bruno Haible <bruno@clisp.org>,
        Xi Ruoyao <xry111@linuxfromscratch.org>, bug-gnulib@gnu.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Tyler Hicks <code@tyhicks.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bo b Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Hans de Goede <hdegoede@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <l@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-mtd@lists.infradead.org, linux-mm@kvack.org,
        linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org
Date:   Wed, 20 Sep 2023 10:12:03 -0400
In-Reply-To: <20230920124823.ghl6crb5sh4x2pmt@quack3>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
         <20230919110457.7fnmzo4nqsi43yqq@quack3>
         <1f29102c09c60661758c5376018eac43f774c462.camel@kernel.org>
         <4511209.uG2h0Jr0uP@nimes>
         <08b5c6fd3b08b87fa564bb562d89381dd4e05b6a.camel@kernel.org>
         <20230920-leerung-krokodil-52ec6cb44707@brauner>
         <20230920101731.ym6pahcvkl57guto@quack3>
         <317d84b1b909b6c6519a2406fcb302ce22dafa41.camel@kernel.org>
         <20230920124823.ghl6crb5sh4x2pmt@quack3>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 2023-09-20 at 14:48 +0200, Jan Kara wrote:
> On Wed 20-09-23 06:35:18, Jeff Layton wrote:
> > On Wed, 2023-09-20 at 12:17 +0200, Jan Kara wrote:
> > > If I were a sysadmin, I'd rather opt for something like
> > > finegrained timestamps + lazytime (if I needed the finegrained timest=
amps
> > > functionality). That should avoid the IO overhead of finegrained time=
stamps
> > > as well and I'd know I can have problems with timestamps only after a
> > > system crash.
> >=20
> > > I've just got another idea how we could solve the problem: Couldn't w=
e
> > > always just report coarsegrained timestamp to userspace and provide a=
ccess
> > > to finegrained value only to NFS which should know what it's doing?
> > >=20
> >=20
> > I think that'd be hard. First of all, where would we store the second
> > timestamp? We can't just truncate the fine-grained ones to come up with
> > a coarse-grained one. It might also be confusing having nfsd and local
> > filesystems present different attributes.
>=20
> So what I had in mind (and I definitely miss all the NFS intricacies so t=
he
> idea may be bogus) was that inode->i_ctime would be maintained exactly as
> is now. There will be new (kernel internal at least for now) STATX flag
> STATX_MULTIGRAIN_TS. fill_mg_cmtime() will return timestamp truncated to
> sb->s_time_gran unless STATX_MULTIGRAIN_TS is set. Hence unless you set
> STATX_MULTIGRAIN_TS, there is no difference in the returned timestamps
> compared to the state before multigrain timestamps were introduced. With
> STATX_MULTIGRAIN_TS we return full precision timestamp as stored in the
> inode. Then NFS in fh_fill_pre_attrs() and fh_fill_post_attrs() needs to
> make sure STATX_MULTIGRAIN_TS is set when calling vfs_getattr() to get
> multigrain time.

> I agree nfsd may now be presenting slightly different timestamps than use=
r
> is able to see with stat(2) directly on the filesystem. But is that a
> problem? Essentially it is a similar solution as the mgtime mount option
> but now sysadmin doesn't have to decide on filesystem mount how to report
> timestamps but the stat caller knowingly opts into possibly inconsistent
> (among files) but high precision timestamps. And in the particular NFS
> usecase where stat is called all the time anyway, timestamps will likely
> even be consistent among files.
>=20

I like this idea...

Would we also need to raise sb->s_time_gran to something corresponding
to HZ on these filesystems? If we truncate the timestamps at a
granularity corresponding to HZ before presenting them via statx and the
like then that should work around the problem with programs that compare
timestamps between inodes.

With NFSv4, when a filesystem doesn't report a STATX_CHANGE_COOKIE, nfsd
will fake one up using the ctime. It's fine for that to use a full fine-
grained timestamp since we don't expect to be able to compare that value
with one of a different inode.

I think we'd want nfsd to present the mtime/ctime values as truncated,
just like we would with a local fs. We could hit the same problem of an
earlier-looking timestamp with NFS if we try to present the actual fine-
grained values to the clients. IOW, I'm convinced that we need to avoid
this behavior in most situations.

If we do this, then we technically don't need the mount option either.
We could still add it though, and have it govern whether fill_mg_cmtime
truncates the timestamps before storing them in the kstat.
--=20
Jeff Layton <jlayton@kernel.org>
