Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E732C3156B4
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Feb 2021 20:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbhBITVZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Feb 2021 14:21:25 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:34059 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233395AbhBITHl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Feb 2021 14:07:41 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 3FF455C007C;
        Tue,  9 Feb 2021 13:02:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 09 Feb 2021 13:02:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=X8JHeJI0jifWj32lcFfp3IdHbBs
        iMGZEJ1JcWLUjvD4=; b=WzngjyK3rwMZATsFPig7OpPeVk7+cmjpaf2cV3STv1a
        R/HKORozPGFGo8euVjnGsHn6R40HCCMKx+7xoWZM9JJ/kFqKwyRlV9DYQJbVEwN3
        2EQc6XXyturSqr6k/qsv7SlKE+gbHugIuGLGso1p0nL4K40sJsicywHyBYctY7sf
        Pils0vbQapd0fHDLDQge2dFhNIOzhZtxfgsuE0valwJazPQHg8gWFcE3Y1fezzUE
        InmuQ4tDFTXQ4Pp/vtHfcm9PNfV5oup05TZDY1yjIVyqHvWVRra35EgtbFMH6Ast
        uK4SgfMhgRT7PqNK77yWukS6gArgiskKDI9QC0cn1kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=X8JHeJ
        I0jifWj32lcFfp3IdHbBsiMGZEJ1JcWLUjvD4=; b=RSfyUI+Ibgdwqm5a2szAtr
        m3T6W72gXnKQ0CgQthsj/zpMUaMQfioaxNXqAO5tHe+dQzKPoNx6o75bUGCU8U1R
        9ir2v46/1jp0/96JdAjQn8U78nGFfZyMLiN17lIyzt10ZeQ/+Z44rVezUOH61uch
        npDx/vQB57t5yHf9y5lPZX7yMUEOBMwNR1qPORydPD847e5qWEj4ggo17UTOa89J
        Bmoq4OCYenDpnWx5Pebkzhnza1G7XtfKFr/55qtRbcl5mEqPszMAdYJ0nuqQWOeK
        ItOjv31DSZkUDK+z/vXXUXTbON74BpqqAov4lfyiQ2l7QygYR1UFDmMm+mKsfoWw
        ==
X-ME-Sender: <xms:Sc4iYGxPNUrGy18NpHBIl6SG_YBOQzsJ5ni7Z9RntVkxoyWxn3fV9g>
    <xme:Sc4iYM3mh8t3cOAg8BNZllQ4J_zJZeOk9POyFI6Q6gT1ReIdoZe0IR7zEx_o5-EZl
    j25LpzyXOd-u6oUvpY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrheehgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujggfsehttd
    ertddtredvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepvdfhgffhteeugefgtdegudevudegkeeguedvvd
    fhudegudfhteekvedtiedtgeeunecukfhppeduieefrdduudegrddufedvrdefnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:Sc4iYE6BVSYlWohiMx5FWzmF7pVN7E29Yeiw7-V-GyFSF1RLDwtpVw>
    <xmx:Sc4iYPVXvakxZ61dJXZI2tQ2Q_7SIC4NBJh-BdiATE5iqlLesGPQKQ>
    <xmx:Sc4iYDDfFj2FWTrmva8doDlmity9mreCxJ5Rwq8amSRAtMQGhoOW7w>
    <xmx:Ss4iYHUdoYrNdYyff15rT-K5w0-OEhWrX3kmgJ3PhmpvhvQkyP0JiQ>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8552224006C;
        Tue,  9 Feb 2021 13:02:49 -0500 (EST)
Date:   Tue, 9 Feb 2021 10:02:46 -0800
From:   Boris Burkov <boris@bur.io>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs-progs: corrupt generic item data with
 btrfs-corrupt-block
Message-ID: <20210209180246.GB2670499@devbig008.ftw2.facebook.com>
References: <cover.1612468824.git.boris@bur.io>
 <039c272f2bd6e8e0bb428c8f0b794e61d491aeef.1612468824.git.boris@bur.io>
 <20210209062247.GA3008@realwakka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209062247.GA3008@realwakka>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 09, 2021 at 06:22:47AM +0000, Sidong Yang wrote:
> On Thu, Feb 04, 2021 at 12:09:31PM -0800, Boris Burkov wrote:
> 
> Hi Boris, I have a question for this code.
> 
> > btrfs-corrupt-block already has a mix of generic and specific corruption
> > options, but currently lacks the capacity for totally arbitrary
> > corruption in item data.
> > 
> > There is already a flag for corruption size (bytes/-b), so add a flag
> > for an offset and a value to memset the item with. Exercise the new
> > flags with a new variant for -I (item) corruption. Look up the item as
> > before, but instead of corrupting a field in the item struct, corrupt an
> > offset/size in the item data.
> > 
> > The motivating example for this is that in testing fsverity with btrfs,
> > we need to corrupt the generated Merkle tree--metadata item data which
> > is an opaque blob to btrfs.
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  btrfs-corrupt-block.c | 71 +++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 68 insertions(+), 3 deletions(-)
> > 
> > diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
> > index 0c022a8e..bf1ce9c5 100644
> > --- a/btrfs-corrupt-block.c
> > +++ b/btrfs-corrupt-block.c
> > @@ -116,11 +116,13 @@ static void print_usage(int ret)
> >  	printf("\t-m   The metadata block to corrupt (must also specify -f for the field to corrupt)\n");
> >  	printf("\t-K <u64,u8,u64> Corrupt the given key (must also specify -f for the field and optionally -r for the root)\n");
> >  	printf("\t-f   The field in the item to corrupt\n");
> > -	printf("\t-I <u64,u8,u64> Corrupt an item corresponding to the passed key triplet (must also specify the field to corrupt and root for the item)\n");
> > +	printf("\t-I <u64,u8,u64> Corrupt an item corresponding to the passed key triplet (must also specify the field, or bytes, offset, and value to corrupt and root for the item)\n");
> >  	printf("\t-D <u64,u8,u64> Corrupt a dir item corresponding to the passed key triplet, must also specify a field\n");
> >  	printf("\t-d <u64,u8,u64> Delete item corresponding to passed key triplet\n");
> >  	printf("\t-r   Operate on this root\n");
> >  	printf("\t-C   Delete a csum for the specified bytenr.  When used with -b it'll delete that many bytes, otherwise it's just sectorsize\n");
> > +	printf("\t-v   Value to use for corrupting item data\n");
> > +	printf("\t-o   Offset to use for corrupting item data\n");
> >  	exit(ret);
> >  }
> >  
> > @@ -896,6 +898,50 @@ out:
> >  	return ret;
> >  }
> >  
> > +static int corrupt_btrfs_item_data(struct btrfs_root *root,
> > +				   struct btrfs_key *key,
> > +				   u64 bogus_offset, u64 bogus_size,
> > +				   char bogus_value)
> > +{
> > +	struct btrfs_trans_handle *trans;
> > +	struct btrfs_path *path;
> > +	int ret;
> > +	void *data;
> > +	struct extent_buffer *leaf;
> > +	int slot;
> > +
> > +	path = btrfs_alloc_path();
> > +	if (!path)
> > +		return -ENOMEM;
> > +
> > +	trans = btrfs_start_transaction(root, 1);
> > +	if (IS_ERR(trans)) {
> > +		fprintf(stderr, "Couldn't start transaction %ld\n",
> > +			PTR_ERR(trans));
> > +		ret = PTR_ERR(trans);
> > +		goto free_path;
> > +	}
> > +
> > +	ret = btrfs_search_slot(trans, root, key, path, 0, 1);
> > +	if (ret != 0) {
> > +		fprintf(stderr, "Error searching to node %d\n", ret);
> > +		goto commit_txn;
> 
> This is error case. but this code goes to commit transaction. I think there is
> an option to abort transaction. This code has pros than aborting?
> 

Good question. To be perfectly honest, I copied this pattern from some
of the other corruption functions around, and don't have a good answer.
Looking at it now, I don't see any harm in either approach (we don't
have any work to commit since it was just search_slot that failed) but
abort does seem less surprising.

> > +	}
> > +	leaf = path->nodes[0];
> > +	slot = path->slots[0];
> > +	data = btrfs_item_ptr(leaf, slot, void);
> > +	// TODO: check offset/size legitimacy
> > +	data += bogus_offset;
> > +	memset_extent_buffer(leaf, bogus_value, (unsigned long)data, bogus_size);
> > +	btrfs_mark_buffer_dirty(leaf);
> > +
> > +commit_txn:
> > +	btrfs_commit_transaction(trans, root);
> > +free_path:
> > +	btrfs_free_path(path);
> > +	return ret;
> > +}
> > +
> >  static int delete_item(struct btrfs_root *root, struct btrfs_key *key)
> >  {
> >  	struct btrfs_trans_handle *trans;
> > @@ -1151,6 +1197,8 @@ int main(int argc, char **argv)
> >  	u64 root_objectid = 0;
> >  	u64 csum_bytenr = 0;
> >  	char field[FIELD_BUF_LEN];
> > +	u64 bogus_value = (u64)-1;
> > +	u64 bogus_offset = (u64)-1;
> >  
> >  	field[0] = '\0';
> >  	memset(&key, 0, sizeof(key));
> > @@ -1177,11 +1225,13 @@ int main(int argc, char **argv)
> >  			{ "delete", no_argument, NULL, 'd'},
> >  			{ "root", no_argument, NULL, 'r'},
> >  			{ "csum", required_argument, NULL, 'C'},
> > +			{ "value", required_argument, NULL, 'v'},
> > +			{ "offset", required_argument, NULL, 'o'},
> >  			{ "help", no_argument, NULL, GETOPT_VAL_HELP},
> >  			{ NULL, 0, NULL, 0 }
> >  		};
> >  
> > -		c = getopt_long(argc, argv, "l:c:b:eEkuUi:f:x:m:K:I:D:d:r:C:",
> > +		c = getopt_long(argc, argv, "l:c:b:eEkuUi:f:x:m:K:I:D:d:r:C:v:o:",
> >  				long_options, NULL);
> >  		if (c < 0)
> >  			break;
> > @@ -1244,6 +1294,12 @@ int main(int argc, char **argv)
> >  			case 'C':
> >  				csum_bytenr = arg_strtou64(optarg);
> >  				break;
> > +			case 'v':
> > +				bogus_value = arg_strtou64(optarg);
> > +				break;
> > +			case 'o':
> > +				bogus_offset = arg_strtou64(optarg);
> > +				break;
> >  			case GETOPT_VAL_HELP:
> >  			default:
> >  				print_usage(c != GETOPT_VAL_HELP);
> > @@ -1368,7 +1424,16 @@ int main(int argc, char **argv)
> >  		if (!root_objectid)
> >  			print_usage(1);
> >  
> > -		ret = corrupt_btrfs_item(target_root, &key, field);
> > +		if (*field != 0)
> > +			ret = corrupt_btrfs_item(target_root, &key, field);
> > +		else if (bogus_offset != (u64)-1 &&
> > +			 bytes != (u64)-1 &&
> > +			 bogus_value != (u64)-1)
> > +			ret = corrupt_btrfs_item_data(target_root, &key,
> > +						      bogus_offset, bytes,
> > +						      bogus_value);
> > +		else
> > +			print_usage(1);
> >  		goto out_close;
> >  	}
> >  	if (delete) {
> > -- 
> > 2.24.1
> > 
