Return-Path: <linux-btrfs+bounces-3381-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECBE87F4A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 01:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABFC31C21A72
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 00:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382C98465;
	Tue, 19 Mar 2024 00:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Y1StcehO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E1jCiQ8h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25C6539C
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 00:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710808458; cv=none; b=Tf3mQWQ0mTHUAuLT0oj426Tc7VgHiEvnL5el3I5G+q6TunUivAltCqQyZqw11cbJz4+OZ98+rhtrYKmRIGp+GiV/2yIK4T+xpU4NQfqJ3zrDAJ3Bv+U0FlvvlTRl5P7EL4TmhYMQ/6S4jIrwb4yHHi1edDkD5ejtSmL9CV8NfGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710808458; c=relaxed/simple;
	bh=WfB0pTvhAwaZO9EKBiNvtMozgZN710ie/e7j/uSRa8s=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:
	 Subject:Content-Type; b=S5VPqmqV9TeoShGCpNcJpoL9NxNo+zNNSnPxy1aWvtSJEGHR+tn8Gdd4kRnv4tonq7NChqF3AJkMwUd4TCtIksNbehterXjWXw2pmXGuz3l2kVGt1MVHKvCSGj+FADY1vX4HeF6hsgaxGw0ln+RyHa4xJTqMf9eYs/5W1sgw6g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Y1StcehO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E1jCiQ8h; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id AF2BA13800C7;
	Mon, 18 Mar 2024 20:34:15 -0400 (EDT)
Received: from imap53 ([10.202.2.103])
  by compute6.internal (MEProxy); Mon, 18 Mar 2024 20:34:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1710808455; x=1710894855; bh=gWtDWUAX44
	2tmE6bKsQUXsrsi31Ga6ZaV8AeVxauW3c=; b=Y1StcehOaPxmIgvxvx5KeuNfrm
	JjFUt6QeHdJJsm0KnSK/NUVuKlv1P+SoSAwVVzxvgZkVy/3V+OSqX50hzjZ8oFrf
	Fibuu9SfCT3N8TEnCuPbaXK4khLKZfSXuwuF4nXDEDu150C0T4C5Y6XTPHZdljAy
	pDsOBvNvtsq082t9XaprkYJgRG8NCefjB7qEqsavdkmglOV88DAY2U60iMPhuoXG
	TdJszfT+em4P90CQzZsGNRCZF1MefW/x3yAOYgT1rBSySJs5/ePYo3uzaSUtsr5r
	HktlyEsYVctFF9uNgtlAk1ln6Vl7NoSAyqTdU9fMrI7Pl5Q66bYCn8TuqcCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710808455; x=1710894855; bh=gWtDWUAX442tmE6bKsQUXsrsi31G
	a6ZaV8AeVxauW3c=; b=E1jCiQ8hr8suCY9uO6bQFYufAD9rQGE3xPRUAmeJ5nxi
	qQfHX5/E7tw8zLEGR+j9MehiwIEa73/RWboexzikl/JI5lOQUOjY7w8acT2ESxFu
	vFxkfp7wtHNVCnFkO/tzrMu46zS8XALQr1qvjhkyakYBsft2U7uvABo9ekGc8Van
	FrW7nWutUOfM/UegC51xmpfNz8GgmUMCw1lHia2RO03OqknvOqtkLd7iRJB7Smbu
	kIN/w6DtYZ6+9um8TIJrUQ3XCoLNRgJ9K62P/zMcewb916VdXnxCUli2qPKqauLz
	oIA8ppzT0hj1nIKZSH0FLTkKNbb7rjKJXNLwFguXqg==
X-ME-Sender: <xms:h934ZT_UZ0KyGXdBYob6XMxJ8ugYHKw3mcfwQSNzrFtbJpjBo95HGQ>
    <xme:h934ZfsU8CL5clKnctOOe5gTcKLP2qwH1XVjoEpHZWhe8-4JS080kpTJ6l_S9i2z3
    dLt_-iU34YMEiYjVXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeekgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvffutgesthdtre
    dtreertdenucfhrhhomhepkhhinhgurdhmohhonhdukeeivdesfhgrshhtmhgrihhlrdgt
    ohhmnecuggftrfgrthhtvghrnhephffgheetvdeuueevkeekkeeggfefveejkeevueeive
    etveehueegleethfetffdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepkhhinhgurdhmohhonhdukeeivdesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:h934ZRDJ1os7JMcg8Buc7OW-IsOpmThxk0-Zi4pj8sQkAGjgbWI8Fg>
    <xmx:h934ZfdnuwIvQRX3_P8-XW7nfcbfOKZuzyQ1lh47foqkA21h4ZkJsQ>
    <xmx:h934ZYPyKs-ZuPC8qIv8RJEtiUAogpO7Ba8JSRG1PdUTyoVyGnvFbQ>
    <xmx:h934ZRmQ1XZOE-OzKpQu-xxvC74k729QxmAWtMupf0BJH95aod7uow>
    <xmx:h934ZRat4oe6Zmm5GqTpp32ueFvJHRsvnEdskzGOMDLEn-1v7t740Q>
Feedback-ID: i35d941ae:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6A08036400AC; Mon, 18 Mar 2024 20:34:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-300-gdee1775a43-fm-20240315.001-gdee1775a
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c233ac4a-dbce-4851-a8f3-78de0827ef19@app.fastmail.com>
In-Reply-To: <e52a27e8-3b6f-4e33-bf0b-a225d7681454@gmx.com>
References: <37de8ead-fefa-4fab-a0ed-bbdb2bf15cf4@app.fastmail.com>
 <e52a27e8-3b6f-4e33-bf0b-a225d7681454@gmx.com>
Date: Mon, 18 Mar 2024 17:33:55 -0700
From: kind.moon1862@fastmail.com
To: "Qu Wenruo" <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: Help requested: btrfs can't read superblock
Content-Type: text/plain

On Mon, Mar 18, 2024, at 17:06, Qu Wenruo wrote:

> Use "mount -o rescue=all,ro" instead.

Thank you for your suggestion.  Should I run it under CentOS 7 (the original OS) or under the newer kernel in the SystemRescue distro?

