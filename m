Return-Path: <linux-btrfs+bounces-6939-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 078D8943975
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2024 01:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AB761C21951
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 23:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DB916E86F;
	Wed, 31 Jul 2024 23:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="eghOI7PW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IO1YRly8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0670C16E863
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 23:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722469443; cv=none; b=j3cpIIsWnan8qzM18p/Yo7255yAhvSPChEcNFmUw7HXdGa7jdfUd4AIquH7D8HK1c368d7US8z8qHzsWU0dJlrT4dlI0nX0XulEYtncuk9X+/oI60XXRmTqazFAqTXeVIFAmaQa+y9JH9bfMdjm4jFL20FnrxLgYLqEVFobCHqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722469443; c=relaxed/simple;
	bh=HwlgBPz7jwHXH3DrVVumvqYGwOPb93wog+WyIuz90F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RN9zX7YOd0UJ0J22JIb2TO8B3QxXUqUUYkZUKhk4mdtIzmC+33TYpbEVvdx+V0D7BAi+0l637qtTu9Jjxl/ppWzoqfJM5DB2uHldLbt3KsZS8LOYUiOIpWhszeg8+TbceO/FOI7R7PVFjayfoMrM6i1+1o86f99H7QyMxyCgD0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=eghOI7PW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IO1YRly8; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 234041146DDC;
	Wed, 31 Jul 2024 19:44:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 31 Jul 2024 19:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1722469440;
	 x=1722555840; bh=7sN/GSgGz76jozFIBpFAMW4HMa6sLt9AEnRIA+J8Yw8=; b=
	eghOI7PWFss9+HkBoaaNxwKKLQwWrpwfUsimUJmxCM0Tl7FPK4uZdDaq+XU/cMiS
	zY98AuvdmMj6xDD1gl+sO63sL0h0rDm2ujjyKsj+c2H7pHQv2U9+WZZfGYC7Nf33
	W+tGmhwqUlFi65BCPqAk4MUYy+go5EprWhB0SiYUymDxTE9bdZV1Cy+NC8M0x2ru
	SzU50pjOTMoZcd+isNY0g29cMG0h0PEHasYQWwXEY1CNgDMV0AZ19LUo9GMqkAyW
	qwlrpDQafDDp17QAvW55Wn7w/BkVv7oWN04kNnjd1tOgASnnmE/MNN+9MKT3K2nz
	fnALhLlYrJWnC+2MT9uhkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722469440; x=
	1722555840; bh=7sN/GSgGz76jozFIBpFAMW4HMa6sLt9AEnRIA+J8Yw8=; b=I
	O1YRly8/vKMcB92i0OP6BEqpzqPvbgAMH/gDnJ+AI+kybJl+Z8AB+WOE/8vlQWHr
	L70eFeAZNcjulqkkXUET1sSwsK1JMa/2JQJw/y7ZZg6AVdWSO8DNkWK0atLoqHT8
	G6a/0AKiBRcgjOEdA04EA8DWlNUPUtn768ALMpPc6IYrFColJERfW8KRpEwGNEbs
	97/WM4z+Z3O4KwPe2aMpDY6pPpbl8Q0Rxl/JFBZAtQ+35eBAiKhg3G7JkwYPLh0q
	jL1Vv+/6+6KF2rd1YcrHLkvYF7ydBcaHEmw4mnkWy9fdAuFxGdDx+SG3E7muVgYs
	UZIY1XzLV/vg6DhT/qpmQ==
X-ME-Sender: <xms:P8yqZnYu7BeotCy1bu_rBZ_zUDnc4ucQGyFn-yVXLjRSuNg9XDuxww>
    <xme:P8yqZmboC9Kd3W-LOOUy39zNbjRi5nL-J7R6dWMxqBW_qrW-MsR_XU3p2oylhFJM6
    12Tx3H-42s30xXj5ro>
X-ME-Received: <xmr:P8yqZp_vRcuqV2YoANO-LoLBW4Od7auB-e1t31c4e69--y1IVIaH5XuzWhaWWk3e4VI2Sy3pJBt1GLyiZ489G-oxcUY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeejgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    eikeetvdfhjeevheeiteduvddvffekieelleekjefgkeeihfeukedvhffghfffkeenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthho
    pedt
X-ME-Proxy: <xmx:P8yqZtpMh2_87rmfO7jp6OezOiDwCHZjS3OQOICsDj6f2OsS5eaNmw>
    <xmx:P8yqZipZ4ywOnOm4s6r-2ZdwJWpNggIB8lrVSvnbCzPvlq7f6h8ULg>
    <xmx:P8yqZjRPh37xywwxAhEa-VdM_9-TqDOaLMHvtkNg3q2sZGBsRKftmQ>
    <xmx:P8yqZqoCU__sss_A-G9u-Z8ENjgNIlGPq8LZnG7COgg__cyNZBF1OQ>
    <xmx:QMyqZlXnzv3qY4_7zBOhFBQ_81L3Vg6pYITWibSZYKNIsnltRyLWhgbN>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jul 2024 19:43:59 -0400 (EDT)
Date: Wed, 31 Jul 2024 16:42:31 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs-progs: mkfs: rework how we traverse rootdir
Message-ID: <20240731234231.GA3809836@zen.localdomain>
References: <cover.1722418505.git.wqu@suse.com>
 <667ee4f02fdc2cb6f186eb8b06dd089f3ce53141.1722418505.git.wqu@suse.com>
 <20240731225935.GB3808023@zen.localdomain>
 <dd3444f9-c8be-46e7-97b1-8f95a161c709@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd3444f9-c8be-46e7-97b1-8f95a161c709@gmx.com>

On Thu, Aug 01, 2024 at 08:49:39AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/8/1 08:29, Boris Burkov 写道:
> > On Wed, Jul 31, 2024 at 07:08:47PM +0930, Qu Wenruo wrote:
> > > There are several hidden pitfalls of the existing traverse_directory():
> > > 
> > > - Hand written preorder traversal
> > >    Meanwhile there is already a better written standard library function,
> > >    nftw() doing exactly what we need.
> > 
> > This is great!
> > 
> > > 
> > > - Over-designed path list
> > >    To properly handle the directory change, we have structure
> > >    directory_name_entry, to record every inode until rootdir.
> > > 
> > >    But it has two string members, dir_name and path, which is a little
> > >    overkilled.
> > >    As for preorder traversal, we will never need to read the parent's
> > >    filename, just its inode number.
> > > 
> > >    And it's exported while no one utilizes it out of mkfs/rootdir.c.
> > > 
> > > - Weird inode numbers
> > >    We use the inode number from st->st_ino, with an extra offset.
> > >    This by itself is not safe, if the rootdir has child directory in
> > >    another filesystem.
> > 
> > Can you explain what you mean by not safe? As far as I can tell, the
> > +256 is to handle that particular invariant of btrfs. Are you worried
> > about duplicate inode numbers in the vein of the usual st_dev/st_ino
> > debates?
> 
> I'm worried about this case:
> 
> rootdir (on fs1)
> |- dir1
> |  |- file1 (fs1, ino 1024)
> |- dir2 (on fs2)
>    |- file2 (fs2, ino 1024)
> 
> We do not have any cross mount point checks.
> 
> I created a case like this:
> 
> # fallocate -l 1G 1.img
> # fallocate -l 1G 2.img
> # mkfs.ext4 1.img
> # mkfs.ext4 2.img
> # mount 1.img mnt
> # mkdir mnt/dir1 mnt/dir2
> # touch mnt/dir1/file1 mnt/file1
> # umount mnt
> # mount 2.img mnt
> # mkdir mnt/dir1 mnt/dir2
> # touch mnt/dir1/file1 mnt/file1
> # umount mnt
> # mkdir rootdir
> # mount 1.img rootdir
> # mount 2.img rootdir/dir2
> # mkfs.btrfs -f --rootdir rootdir test.img
> ERROR: item file1 already exists but has wrong st_nlink 1 <= 1
> ERROR: unable to traverse directory rootdir/: 1
> ERROR: error while filling filesystem: 1
> 
> And it failed as expeceted.
> 

Perfect example, it did seem to be vulnerable to this with just
"original st_ino + 256"... Thanks for the new test.

> > 
> > In that case, if this is a bugfix, I think it makes sense to write a
> > regression test that highlights it. It would be nice to pull the fix
> > out of the refactor, too, but I suppose that with such a deep refactor,
> > that might not be possible/worth it.
> 
> Unfortunately I didn't even notice how serious these problems are, until
> I tried...

That's kind of my concern with the higher level testing question, that
we don't have much coverage for such a big refactor. OTOH, if we already
had such serious bugs, how bad could the refactor really be :)

> 
> Will add two new test cases. One is the above one, the other is the
> hardlink out of rootdir bug I mentioned in 3/3.
> 
> > 
> > > 
> > >    And this results very weird inode numbers, e.g:
> > > 
> > > 	item 0 key (256 INODE_ITEM 0) itemoff 16123 itemsize 160
> > > 	item 6 key (88347519 INODE_ITEM 0) itemoff 15815 itemsize 160
> > > 	item 16 key (88347520 INODE_ITEM 0) itemoff 15363 itemsize 160
> > > 	item 20 key (88347521 INODE_ITEM 0) itemoff 15119 itemsize 160
> > > 	item 24 key (88347522 INODE_ITEM 0) itemoff 14875 itemsize 160
> > > 	item 26 key (88347523 INODE_ITEM 0) itemoff 14700 itemsize 160
> > > 	item 28 key (88347524 INODE_ITEM 0) itemoff 14525 itemsize 160
> > > 	item 30 key (88347557 INODE_ITEM 0) itemoff 14350 itemsize 160
> > > 	item 32 key (88347566 INODE_ITEM 0) itemoff 14175 itemsize 160
> > > 
> > >    Which is far from a regular fs created by copying the data.
> > 
> > +1, especially since it doesn't even *preserve* the inode numbers, which
> > would be a comprehensible (if not working) behavior. Creating the oids
> > in "btrfs order" seems like a nice improvement!
> > 
> > > 
> > > - Weird directory inode size calculation
> > >    Unlike kernel, which updated the directory inode size every time new
> > >    child inodes are added, we calculate the directory inode size by
> > >    searching all its children first, then later new inodes linked to this
> > >    directory won't touch the inode size.
> > > 
> > > Enhance all these points by:
> > > 
> > > - Use nftw() to do the preorder traversal
> > >    It also provides the extra level detection, which is pretty handy.
> > > 
> > > - Use a simple local inode_entry to record each parent
> > >    The only value is a u64 to record the inode number.
> > >    And one simple rootdir_path structure to record the list of
> > >    inode_entry, alone with the current level.
> > > 
> > >    This rootdir_path structure along with two helpers,
> > >    rootdir_path_push() and rootdir_path_pop(), along with the
> > >    preorder traversal provided by nftw(), are enough for us to record
> > >    all the parent directories until the rootdir.
> > > 
> > > - Grab new inode number properly
> > >    Just call btrfs_get_free_objectid() to grab a proper inode number,
> > >    other than using some weird calculated value.
> > > 
> > > - Use btrfs_insert_inode() and btrfs_add_link() to update directory
> > >    inode automatically
> > > 
> > > With all the refactor, the code is shorter and easier to read.
> > 
> > Agreed on all counts, I think this is a lovely refactor.
> > 
> > For a change of this magnitude, I think it is helpful to justify the
> > correctness of the change by documenting the testing plan. Are there
> > existing unit tests of mkfs that cover all the cases we are modifying
> > here?
> 
> We have existing rootdir test cases, from the regular functional tests,
> to corner cases.
> 
> But we lack corner cases of corner cases, like duplicating inode number
> (cross mnt) and hard links.
> 
> > Is there some --rootdir master case that covers everything?
> 
> It's inside tests/mkfs-tests/
> 
> A quick grep shows:
> 
> 004-rootdir-keeps-size
> 009-special-files-for-rootdir
> 011-rootdir-create-file
> 012-rootdir-no-shrink
> 014-rootdir-inline-extent
> 016-rootdir-bad-symbolic-link
> 021-rfeatures-quota-rootdir
> 022-rootdir-size
> 027-rootdir-inode

Thanks for collecting those. By scanning those, it's hard to tell if
there is, for example, a test of an "interesting" directory structure
like the one I drew above, to test the traversal, for example.

Out of curiousity, I applied your patches, ran the tests (pass) then
put a bug in the traversal code (only pop on cur_lvl > ftw_level, not
ftw_level - 1) and 004-rootdir-keeps-size did fail, as it ran on the
Documentation/ dir, which does seem like a sufficiently interesting
directory.

I feel a bit better now :)

Maybe something that ran after fsstress (or however we test send/recv?)
in the long run would be a good test, as we nail down some of the bugs
you have hit here.

This comment is not directed at you, but is more general for btrfs
development: I think explicitly stating the testing conducted on a
complex patch is really helpful for reviewers.

> 
> 
> > Is it
> > in fstests? Knowing that all of the new code has at least run correctly
> > would go a long way to feeling confident in the details of the
> > transformation.
> 
> We have btrfs-progs github CI, runs the all the selftests on each PR.
> And it's all green (except a typo caught by code spell).
> 
> [...]
> > > -	parent_inum = highest_inum + BTRFS_FIRST_FREE_OBJECTID;
> > > -	dir_entry->inum = parent_inum;
> > > -	list_add_tail(&dir_entry->list, &dir_head->list);
> > > +	/*
> > > +	 * If our path level is higher than this level - 1, this means
> > > +	 * we have changed directory.
> > > +	 * Poping out the unrelated inodes.
> > 
> > Popping
> 
> Exposed by the CI, and fixed immediately in github.
> 

Cool!

> > 
> > Also, this took me like 15 minutes of working examples to figure out why
> > it worked. I think it could definitely do with some deeper explanation
> > of the invariant, like:
> > 
> > ftwbuf->level - 1 is the level of the parent of the current traversed
> > inode. ftw will traverse all inodes in a directory before leaving it,
> > and will never traverse an inode without first traversing its dir,
> > so if we see a level less than or equal to the last directory we saw,
> > we are finished with that directory and can pop it.
> > 
> > Perhaps with an annotated drawing like:
> > 
> > 0: /
> > 1:         /foo/
> > 2:                 /foo/bar/
> > 3:                         /foo/bar/f
> > 2:                 /foo/baz/            POP! 2 > (2 - 1); done with /foo/bar/
> > 3:                         /foo/baz/g
> > 1:         /h                           POP! 2 > (1 - 1); done with /foo/baz/
> > 
> > To help make it clearer. I honestly even think just changing to >= makes
> > it clearer? Not sure about that.
> 
> I'll add comments with an example to explain the workflow.
> 
> BTW, David and I are working with Github review system a lot recently:
> https://github.com/kdave/btrfs-progs/pull/855
> 
> We do not force anyone to use specific system to do anything, but you
> may find it a little easier to comment, and feel free to fall back to
> the mail based review workflow at any time.

Happy to do code review in PRs! It's a bit annoying that the history
gets blown up when the author re-pushes the branch after incorporating
feeback (never understood that design, Phabricator tracks the *branch*
history too and it seems very helpful to me.)

BTW, if this review style is going well, we should discuss more and get
the workflow more documented/supported in the workflow docs.

Also, while we are still here in email-land, you can add
Reviewed-by: Boris Burkov <boris@bur.io>

Thanks,
Boris

> 
> Thanks a lot for the detailed review!
> Qu

