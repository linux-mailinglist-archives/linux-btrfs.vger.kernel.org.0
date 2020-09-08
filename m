Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87789262144
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Sep 2020 22:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgIHUlR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Sep 2020 16:41:17 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37445 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726484AbgIHUlP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Sep 2020 16:41:15 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 7507A5C0218;
        Tue,  8 Sep 2020 16:41:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 08 Sep 2020 16:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=fm1; bh=rOKQqCUBetaDwqYEjcQReHGxjyiDcysIV83hLCOd
        wjM=; b=lm9h6TYVyrOKtwPoma5es7K3JXgvrDZoDfSssL5UxtYiE+zBTA2M4Kuv
        NvKuG70Wbog6Ek5g66LEeac3GJtJFoA6olNOk9xkm/ZAl8NfqwnZjHqhg31Cb0lh
        /NZSw9grVCvReJwcDAk0HcuBFHQ4B/nwfcVL/4gL9SlS0rQPbxjzkFOntP3UFpOs
        YF+acQmIHdgB0xpAM5JHFNwHe+y+EpdWSZg/j4GOd7kGlr4uNyqs2cdA248hMWF7
        CbYYuERn/lJDkc+HQXHoHyVBsXqBRQFKvtbW2x19M2BFn4ydzkItwfLPAVqFyYKB
        3UxGM6phKj01XZO6WWaT4DQw/RVR5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=rOKQqC
        UBetaDwqYEjcQReHGxjyiDcysIV83hLCOdwjM=; b=B8K2ctnN/t/ca2JEJIph6U
        UW03/rO2jsl3RvttpYf+3fr9Fhjv2fABytuv4O8ejK6v+dEXipZXZe4d3c0pD0zt
        E7dfek7r4e0Zry6OxuYGXhNVVZYy/SOu+pWSnOHmuZ1nt5DQaAuPtsVxI5RHkl6w
        dPZDp2iiB4apGug7ask4UekuUEnl5U0t2FosI3GnhGjnUCyGm1Q9GF+rP9vBjlT5
        TLNONqVXOEQK8mnyPKzSm5uJ0Z/R2ae0pep9vZyIGMtm+qTfPS5Th6dgYtcAhDnb
        jXMmoVOO3zb+v18RbTQgPonaPzEGb0e9QC+zZnnjeB23x17ERFiPYvcPhdkLT6Yg
        ==
X-ME-Sender: <xms:aOxXX-encZAbdvLTw_-LVuGmR1Y7o7z30j4Gze-agSFa086hjzy8Xw>
    <xme:aOxXX4MjKACs8XPr2HWI6UelN_EABsvAPXLLSjO5atLfwUfyn8v2i5O1GUoIU9iA6
    _s_QJpboMihcLGvrqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehfedgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epvdfhgffhteeugefgtdegudevudegkeeguedvvdfhudegudfhteekvedtiedtgeeunecu
    kfhppeduieefrdduudegrddufedvrdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:aexXX_goI28GHprdPcVYsqt1r6fCo_P-bsac-RWe8Nm9kTO8tndbzA>
    <xmx:aexXX7-tSgIZoXuMh1TJHgR7nqWaXSjas3T9e_Bm5GTJZLpYzU7bJw>
    <xmx:aexXX6tYPRzx3aISmMf0dFpf30LGvULGu_eQzXs8Y9v47jrCWgBRrQ>
    <xmx:aexXX_URfIb071_EjfyLbxTjHwzp8j-0Qz-q-wbgFrRDCLTf7UZ27A>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7460D328005E;
        Tue,  8 Sep 2020 16:41:12 -0400 (EDT)
Date:   Tue, 8 Sep 2020 13:41:08 -0700
From:   Boris Burkov <boris@bur.io>
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] btrfs-progs: support free space tree in mkfs
Message-ID: <20200908204108.GA2424652@devvm842.ftw2.facebook.com>
References: <20200902204453.GN28318@twin.jikos.cz>
 <cf7462fe8c14448703d845d235dce7aca1faf795.1599157021.git.boris@bur.io>
 <20200908195559.GC18399@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908195559.GC18399@twin.jikos.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 08, 2020 at 09:55:59PM +0200, David Sterba wrote:
> On Thu, Sep 03, 2020 at 11:19:23AM -0700, Boris Burkov wrote:
> > Add a runtime feature (-R) flag for the free space tree. A filesystem
> > that is mkfs'd with -R free-space-tree then mounted with no options has
> > the same contents as one mkfs'd without the option, then mounted with
> > '-o space_cache=v2'.
> > 
> > The only tricky thing is in exactly how to call the tree creation code.
> > Using btrfs_create_free_space_tree as is did not quite work, because an
> > extra reference to the eb (root->commit_root) is leaked, which mkfs
> > complains about with a warning. I opted to follow how the uuid tree is
> > created by adding it to the dirty roots list for cleanup by
> > commit_tree_roots in commit_transaction. As a result,
> > btrfs_create_free_space_tree no longer exactly matches the version in
> > the kernel sources.
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> > - add mkfs test
> > - add documentation
> > - add safe version and sysfs file to feature struct
> > 
> >  Documentation/mkfs.btrfs.asciidoc            |  6 ++++++
> >  common/fsfeatures.c                          | 10 ++++++++--
> >  common/fsfeatures.h                          |  3 ++-
> >  kernel-shared/disk-io.c                      |  5 +++++
> >  kernel-shared/free-space-tree.c              |  1 +
> >  mkfs/main.c                                  |  8 ++++++++
> >  tests/mkfs-tests/023-free-space-tree/test.sh | 21 ++++++++++++++++++++
> >  7 files changed, 51 insertions(+), 3 deletions(-)
> >  create mode 100755 tests/mkfs-tests/023-free-space-tree/test.sh
> > 
> > diff --git a/Documentation/mkfs.btrfs.asciidoc b/Documentation/mkfs.btrfs.asciidoc
> > index 630f575c..8f1e1429 100644
> > --- a/Documentation/mkfs.btrfs.asciidoc
> > +++ b/Documentation/mkfs.btrfs.asciidoc
> > @@ -257,6 +257,12 @@ permanent, this does not replace mount options.
> >  Enable quota support (qgroups). The qgroup accounting will be consistent,
> >  can be used together with '--rootdir'.  See also `btrfs-quota`(8).
> >  
> > +*free_space_tree*::
> > +(kernel support since 3.4)
> > ++
> > +Enable the free space tree (mount option space_cache=v2) for persisting the
> > +free space cache.
> > +
> >  BLOCK GROUPS, CHUNKS, RAID
> >  --------------------------
> >  
> > diff --git a/common/fsfeatures.c b/common/fsfeatures.c
> > index 48ab37ca..6c391806 100644
> > --- a/common/fsfeatures.c
> > +++ b/common/fsfeatures.c
> > @@ -104,9 +104,15 @@ static const struct btrfs_feature mkfs_features[] = {
> >  };
> >  
> >  static const struct btrfs_feature runtime_features[] = {
> > -	{ "quota", BTRFS_RUNTIME_FEATURE_QUOTA, NULL,
> > -		VERSION_TO_STRING2(3, 4), NULL, 0, NULL, 0,
> > +	{ "quota", BTRFS_RUNTIME_FEATURE_QUOTA,
> > +		"free_space_tree",
> > +		VERSION_TO_STRING2(3, 4),
> > +		VERSION_TO_STRING2(4, 9),
> > +		NULL, 0,
> 
> This looks mangled, the free_space_tree (sysfs file reference) is in the
> quota entry and the 4.9 version for ->safe use should be in the free-space-tree
> entry below. I'll fix it.
> 

My mistake! I'm very sorry for the sloppy patch. Thanks for fixing it.

> >  		"quota support (qgroups)" },
> > +	{ "free-space-tree", BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE, NULL,
> > +		VERSION_TO_STRING2(4, 5), NULL, 0, NULL, 0,
> > +		"free space tree (space_cache=v2)" },
> 
> >  	/* Keep this one last */
> >  	{ "list-all", BTRFS_FEATURE_LIST_ALL, NULL }
> >  };
