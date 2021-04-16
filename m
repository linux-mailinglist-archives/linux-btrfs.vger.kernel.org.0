Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA38236299C
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 22:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239270AbhDPUqm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 16:46:42 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:50351 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236084AbhDPUql (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 16:46:41 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 45F1314AC;
        Fri, 16 Apr 2021 16:46:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 16 Apr 2021 16:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=fm3; bh=uy7rvyyiisg7Bn544ZXZeORzLiDdfGEi7B5nL6pt
        8L0=; b=lvCDatI1N3JfiYDNs9nTkriOI2acndoGVL5Rtd1xEz8Wh261I+ZfwiM3
        B9N6gohrM1y6LwXjmMbFH7ZXitOuu7NCWw9fBqI4jwS1PsEQkWX1CL9UxWRvcIK5
        TSNYj+sh45aWUKMCs2hllVu1MH9aRAKXWxOf9u9GDF+soWzSUJjRTjl2sAOXncm7
        IbT0GcRmkFVSSRxuzRuIi4hwGyyHx+S8PQdBvWiVQr++EBAoqcf1YGWAkJsbjshp
        ULe7LwZmbMUnpOyXmx4nv6MgPB8Jc5z0k89aZopRATLvMlWsXK1uCDNH1l1+qE3V
        bhS1Q8GfP/jgWXaF+I3NMVkmgMn2VQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=uy7rvy
        yiisg7Bn544ZXZeORzLiDdfGEi7B5nL6pt8L0=; b=l01/Hh0dvBp9740BW7igHX
        CrUpAVg9UPi45/ZAbztA/7w3G7ZiIxYDloqtjaOc4Anjr6DRcnVtMzkLPLbFY64v
        YgjVpQ2f0aGygwMBiWGkH75N7pZmhsGRaJ+ygbQeeZKhtJHr4FSSrH1KU9u8Nm/Z
        nBUZQYufWOQvuumn45PDSRJM4gTAQbsNXQMsO4h1Ng9G/d7mDzRaCTQ4W1onST2b
        1OOkAhGbYkCPxq8Ltkf1WXf8D6gBkXe20ivxLsfhy7/X0Rg8qB016rLpwCluZN2F
        UFWP+SJQ++zy0g0iTC5ItTojD3IEe3UM37X5ys3AMK8t5rtZu29jYbM2iAaQbq5Q
        ==
X-ME-Sender: <xms:l_d5YCDR13TVusNl5deFOh_sHUWREkNEnuTCQhyiVYRDma91Q9p3xg>
    <xme:l_d5YMjmPHf2j2GLbkRoroTr26k046X_mASejzva9ECiSlQ7DFpZk_YtQ0ImXLQTJ
    bJaAQcJdQalcJ54AA4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudelhedgudehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ehudevleekieetleevieeuhfduhedtiefgheekfeefgeelvdeuveeggfduueevfeenucfk
    phepvddtjedrheefrddvheefrdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:l_d5YFlLBqSE60QhC_cVaz7T1lcICHrZrlDcuCrtfnk6m0jnGHvt1Q>
    <xmx:l_d5YAx3T2d_hYBhhM7NQ7dWR8ETP3-tyCfa-3ci8pcGflT6-VzlBQ>
    <xmx:l_d5YHQ8HsXzj1QIQ5x0tBwlpJ4jKHHt_f44A4B3lmmeMxef5qQ8Wg>
    <xmx:l_d5YI4axmA6RuBfZjZpr-R9YIbGph3jb3xxpu3fh5VLUeVLc_aO7Q>
Received: from localhost (unknown [207.53.253.7])
        by mail.messagingengine.com (Postfix) with ESMTPA id D2877108005C;
        Fri, 16 Apr 2021 16:46:14 -0400 (EDT)
Date:   Fri, 16 Apr 2021 13:46:13 -0700
From:   Boris Burkov <boris@bur.io>
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: mkfs: only output the warning if the
 sectorsize is not supported
Message-ID: <YHn3lTwTBxQYT4+i@zen>
References: <20210415053011.275099-1-wqu@suse.com>
 <YHnT8Dwobux2J9Pt@zen>
 <20210416200709.GL7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416200709.GL7604@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 16, 2021 at 10:07:09PM +0200, David Sterba wrote:
> On Fri, Apr 16, 2021 at 11:14:08AM -0700, Boris Burkov wrote:
> > On Thu, Apr 15, 2021 at 01:30:11PM +0800, Qu Wenruo wrote:
> > > +/*
> > > + * The buffer size if strlen("4096 8192 16384 32768 65536"),
> > > + * which is 28, then round up to 32.
> > 
> > I think there is a typo in this comment, because it doesn't quite parse.
> 
> Typo fixed.
> 
> > > + */
> > > +#define SUPPORTED_SECTORSIZE_BUF_SIZE	32
> > >  int btrfs_check_sectorsize(u32 sectorsize)
> > >  {
> > > +	bool sectorsize_checked = false;
> > >  	u32 page_size = (u32)sysconf(_SC_PAGESIZE);
> > >  
> > >  	if (!is_power_of_2(sectorsize)) {
> > > @@ -340,7 +349,32 @@ int btrfs_check_sectorsize(u32 sectorsize)
> > >  		      sectorsize);
> > >  		return -EINVAL;
> > >  	}
> > > -	if (page_size != sectorsize)
> > > +	if (page_size == sectorsize) {
> > > +		sectorsize_checked = true;
> > > +	} else {
> > > +		/*
> > > +		 * Check if the sector size is supported
> > > +		 */
> > > +		char supported_buf[SUPPORTED_SECTORSIZE_BUF_SIZE] = { 0 };
> > > +		char sectorsize_buf[SUPPORTED_SECTORSIZE_BUF_SIZE] = { 0 };
> > > +		int fd;
> > > +		int ret;
> > > +
> > > +		fd = open("/sys/fs/btrfs/features/supported_sectorsizes",
> > > +			  O_RDONLY);
> > > +		if (fd < 0)
> > > +			goto out;
> > > +		ret = read(fd, supported_buf, sizeof(supported_buf));
> > > +		close(fd);
> > > +		if (ret < 0)
> > > +			goto out;
> > > +		snprintf(sectorsize_buf, SUPPORTED_SECTORSIZE_BUF_SIZE,
> > > +			 "%u", page_size);
> > > +		if (strstr(supported_buf, sectorsize_buf))
> > > +			sectorsize_checked = true;
> > 
> > Two comments here.
> > 1: I think we should be checking sectorsize against the file rather than
> > page_size.
> 
> What do you mean by 'against the file'?
> 

I am saying we should do
`snprintf(sectorsize_buf, SUPPORTED_SECTORSIZE_BUF_SIZE, "%u", sectorsize);`
so that we lookup sectorsize, not page_size, in supported_sectorsizes.
Sorry for the confusing wording.

> I read it as comparing what system reports as page size, converted to
> string and looked up in the sysfs file.

Apologies if I am misunderstanding the purpose of this patch, but the way
I understand it is:

Today, on a system with 64K pages, we must use a 64K sectorsize. As part
of supporting a 4K sectorsize, we want to relax this check to allow
sectorsize=4K.

If the user runs mkfs.btrfs -s 4096, how would checking whether 64K
is present in "supported_sectorsizes" help validate the input? As long
page_size is in "supported_sectorsizes", any power of 2 between 4k and
64k is legit. I suppose that could be the logic, but it seems kind of
bizarre to me. If that is really the intent, I would argue the filename
"supported_sectorsizes" doesn't make sense.

> 
> > 2: strstr seems too permissive, since it doesn't have a notion of
> > tokens. If not for the power_of_2 check above, we would admit all kinds
> > of silly things like 409. But even with it, we would permit "4" now and
> > with your example from the comment, "8", "16", and "32".
> 
> In general you're right. Practically speaking, this will work. We know
> what the kernel module puts to that file and if getconf returns some
> absurd number for PAGE_SIZE other things will break. The code assumes
> perfect match, in any other case it prints the warning. So even if
> there are some funny values either in getconf or the sysfs file, it
> leads to something noticealbe to the user. A silent error would be worse
> and worth fixing, but that way around it works.

Looking more closely, I think that the [4k,64k] check mostly covers my
concern anyway. I also agree that we should be pragmatic and not
over-complicate the check. However, I do think if my point above holds,
then the strstr input could be different than just the one fixed page
size.
