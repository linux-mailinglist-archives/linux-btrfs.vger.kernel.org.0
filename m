Return-Path: <linux-btrfs+bounces-2981-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C6D86EF03
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Mar 2024 08:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D8D3B24D27
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Mar 2024 07:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C51D10A3A;
	Sat,  2 Mar 2024 07:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CoNhYu7X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C5C7490
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Mar 2024 07:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709363004; cv=none; b=I4ekcO7IpaBMhkJFlu7IcDsn2wXhm+vaog3gBlgEbnG0rjzekVb+r0CU/baKfnmJkCHei5J7vT388lR7fhP0QFifq4d9HRdkrXv1mu1YJUi9kEuYcJ7G2eq4AhIIEM0jyBJ+oi/0nouLm7hjx/CQMIFTwUY+1XdwZH7gpkMzn/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709363004; c=relaxed/simple;
	bh=Oe8LCqQk6Jl5vQmSQQGx4uSLWfw29owThSDN4hwrknw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMBMW6uDr+1z5WhVQCPY5/SOYQEN8J2XMVTyN1wNnw/01xSwey/tU4/fkz4NsaFNkq7CyOExlGfyjTRaTVU5+Im2zTwVpeENEZUJc2IWjg1PjMocf94bvlme639FUHOID/+57en5YPkswWs6UZG0Io8f7oV8/9gY45gmhRk+2qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CoNhYu7X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709363001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sLZNvbOpD8vnvAhMOsSvxCiLNlhv5ugl0GHIOirJo7w=;
	b=CoNhYu7XP5jBMmtCs1I7Ay4N9Bcv/AicwoqMkwhQqULIf1JnGlaUa2tnVS8MdQnxMlo/4S
	iNG9pec3RGtmKENBhQ0yq/+kyEVUw/gQ0txm9u23K8HOs3W5m0shjNjwM/iyww3mmw2Qf8
	NqzJExClex2CB2Kn+gX6ySuzOeGBI2s=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-k4khgBFkNnag3Il9Irw3rw-1; Sat, 02 Mar 2024 02:03:18 -0500
X-MC-Unique: k4khgBFkNnag3Il9Irw3rw-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5dcab65d604so2259319a12.3
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Mar 2024 23:03:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709362997; x=1709967797;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sLZNvbOpD8vnvAhMOsSvxCiLNlhv5ugl0GHIOirJo7w=;
        b=fvWjRSLTLLV71sIZay3susr3tnlnx0w00/1yZvF4Ok82GcuD4QcQT/G8jNsSQSYk9t
         VnJhlZEKDZOjWfUyhoe8+TEdA5SB2Ibqpic3ZiMC+8AaktkPJ6IomZ6adHMBTp6Xcm9i
         pe8NZDe/GioY5SmohUOBcix48OhlZiDeJH9OU87Jxd5qFFtBhDkF8j9gxSwj0SihjQcu
         Kqbd1mkGqhuev9dlOF0ECgPxWl7yQh/GhalWsTzzCrsIEph8WHMMzJ6OtVFrJE/ecm3g
         uxCb083vTfcst/x/QvdesumlP1URuxGeNx97lhU0N1ZqAru4LHnXQoQ8XZEbOEoLkhBq
         wu8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV77h1DxBaNNJe9jcha3UZH2ZG97I/ZbqfwPrgbe4vAPK+m0JNRH/nnyR2/s1/rId+w9vHVPjfsdlpGtk0KUwQFdPt0kzwzvB93OK4=
X-Gm-Message-State: AOJu0Yx3xGs3QtFXtckhKXWJ4o6eL8hNhfSfOw8GkKPeCy6U5P/qAWer
	mVup2Sg/lx5tHfktMFeL27dDa2mS2qj7thqlya4RBVqSAx8sh7ytaFgrzlTbsoccBTTA7FwoeCS
	coy0rBMJpjylfzN0ApVoiZQofcqF8mLR5DpuIQDZj0PLIW9XaqwiMa5VTCJ8A
X-Received: by 2002:a05:6a20:5483:b0:1a0:9117:5892 with SMTP id i3-20020a056a20548300b001a091175892mr4608218pzk.15.1709362997450;
        Fri, 01 Mar 2024 23:03:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEosXbcldllceXlJufOqOXih0rmRhxQ8ndh1/suLKPTqpBH1Dv3IV87x/FLE+eV4CKXDKweew==
X-Received: by 2002:a05:6a20:5483:b0:1a0:9117:5892 with SMTP id i3-20020a056a20548300b001a091175892mr4608202pzk.15.1709362997118;
        Fri, 01 Mar 2024 23:03:17 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y9-20020a62f249000000b006e535bf8da4sm3894283pfl.57.2024.03.01.23.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 23:03:16 -0800 (PST)
Date: Sat, 2 Mar 2024 15:03:13 +0800
From: Zorro Lang <zlang@redhat.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Su Yue <glass.su@suse.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, l@damenly.org
Subject: Re: [PATCH] btrfs/172,206: call _log_writes_cleanup in _cleanup
Message-ID: <20240302070313.5tc5ylqpv6dyjgmf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240215140236.29171-1-l@damenly.org>
 <20240301134914.dgcv4vh2jbx2egfp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H53QTzMVdJwEJBOyoB3fBem-2zi3FH411JugRDkq9Bqvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H53QTzMVdJwEJBOyoB3fBem-2zi3FH411JugRDkq9Bqvg@mail.gmail.com>

On Fri, Mar 01, 2024 at 02:55:26PM +0000, Filipe Manana wrote:
> On Fri, Mar 1, 2024 at 1:49 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Thu, Feb 15, 2024 at 10:02:36PM +0800, Su Yue wrote:
> > > From: Su Yue <glass.su@suse.com>
> > >
> > > Because block group tree requires require no-holes feature,
> > > _log_writes_mkfs "-O ^no-holes" fails when "-O block-group-tree" is
> > > given in MKFS_OPTION.
> > > Without explicit _log_writes_cleanup, the two tests fail with
> > > logwrites-test device left. And all next tests will fail due to
> > > SCRATCH DEVICE EBUSY.
> > >
> > > Fix it by overriding _cleanup to call _log_writes_cleanup.
> > >
> > > Signed-off-by: Su Yue <glass.su@suse.com>
> > > ---
> > >  tests/btrfs/172 | 6 ++++++
> > >  tests/btrfs/206 | 6 ++++++
> > >  2 files changed, 12 insertions(+)
> > >
> > > diff --git a/tests/btrfs/172 b/tests/btrfs/172
> > > index f5acc6982cd7..fceff56c9d37 100755
> > > --- a/tests/btrfs/172
> > > +++ b/tests/btrfs/172
> > > @@ -13,6 +13,12 @@
> > >  . ./common/preamble
> > >  _begin_fstest auto quick log replay recoveryloop
> > >
> > > +# Override the default cleanup function.
> > > +_cleanup()
> > > +{
> > > +     _log_writes_cleanup &> /dev/null
> >
> > This _cleanup will override the default one, so better to copy the
> > default cleanup in this function,
> >
> >   cd /
> >   rm -r -f $tmp.*
> 
> Zorro,
> 
> You had already replied to v2 of this patch with exactly the same comments:
> 
> https://lore.kernel.org/fstests/20240225162212.qcidpyb2bhdburl6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/

Hi Filipe,

Oh, sorry for this duplicated review, I tried to scan the email list to
make sure I didn't miss something.

> 
> It's trivial to do those changes.
> Do you expect Su to send yet another version just for that, or could
> you amend the patch?

I expect to get a simple response from the author, for his patch.
E.g.:
1) "Yes, agree, could you help to change that when you merge it?"
2) "No, I think it doesn't make sense"
3) "Sure, I'll make a bit change in next version"
4) "Oh, that reminds me, I should cleanup more, I think I can change more about that"
...

Is that hard?

If the author doesn't have any opinions, just asks for the amending from me,
I'll do that if there's not risk. Or I suppose the author always hope to change
his code by himself, maybe not follow the review points 100%.

> 
> Can you please be more clear in future replies about that, i.e. if you
> expect the author to send a new version or if you'll amend the patch
> for trivial changes?

You think it's trivial, due to you think you don't need more changes about
that. But I'm not sure before you say that. You can check the list, I say
"I'll help to change that when I merge it", but just when I'm sure it's clear
enough. You shouldn't use your measure to think my standard.

I didn't say I'll amend that means my review point is a reference, to check
if you have more ideas.
We just got a big regression in a _cleanup function which does:
  cd /
  rm -r -f $tmp.*
  specific_xxxx_cleanup

Then that specific_xxxx_cleanup() remove all things in "/".

If it's
  specific_xxxx_cleanup
  cd /
  rm -r -f $tmp.*

things might be different or not.

I'm not saying that change must makes differences. But the cleanup things
(e.g. theorder of the steps) might worth a bit evaluating, not just changed
by myself without any response. And a reply from the author to the review
points of his patch is not hard. Even just say "yes, please help that",
that means you reviewed and agreed my review points at least.

I'm not anyone else. Each one has his distinctive style. I don't know what's
wrong with that way to deal with patches, to make you such unsatisfied. It is
difficult to cater to all tastes.

Thanks,
Zorro

> 
> Speaking for myself, I very often get confused with your replies, and
> I feel that some patches often get stalled for that reason.
> Usually with Eryu or Dave that didn't happen, the course of action was clear.
> 
> Thanks.
> 
> >
> > You can refer to btrfs/196 or generic/482 etc.
> >
> > > +}
> > > +
> > >  # Import common functions.
> > >  . ./common/filter
> > >  . ./common/dmlogwrites
> > > diff --git a/tests/btrfs/206 b/tests/btrfs/206
> > > index f6571649076f..e05adf75b67e 100755
> > > --- a/tests/btrfs/206
> > > +++ b/tests/btrfs/206
> > > @@ -14,6 +14,12 @@
> > >  . ./common/preamble
> > >  _begin_fstest auto quick log replay recoveryloop punch prealloc
> > >
> > > +# Override the default cleanup function.
> > > +_cleanup()
> > > +{
> > > +     _log_writes_cleanup &> /dev/null
> >
> >
> > Same as above.
> >
> > Thanks,
> > Zorro
> >
> > > +}
> > > +
> > >  # Import common functions.
> > >  . ./common/filter
> > >  . ./common/dmlogwrites
> > > --
> > > 2.43.0
> > >
> > >
> >
> >
> 


