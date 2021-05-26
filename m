Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C7D391CFC
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 18:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbhEZQZo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 May 2021 12:25:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:57468 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232991AbhEZQZo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 May 2021 12:25:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622046252;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I3YhFM5fMmsSKN5pimnsM043lUQkptXTEWHmtQL8R60=;
        b=lui1WrlOZmS3brGs2vtwgaFcEsDyL+dzIagKwwYtOu+oquo0Q1WYEhuK9QqsxhG+7yz8G+
        hiRzCzEU7NNXRtoiJnKvgkC7JNpxp0zi4E78aE7AqF8W+gNTwVo1fICePQvzxAisc403+R
        wXzsMKDzlRgKN0WOJN3UOE/d5WH046M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622046252;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I3YhFM5fMmsSKN5pimnsM043lUQkptXTEWHmtQL8R60=;
        b=baALR91WYUroIqlzmCv8B13rntD9l16y9l66nOfuT4DjMjTGVvTppbe/mxWvuR7KDnnWvC
        USHrweekTECKVlBQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E2DDEB2CF;
        Wed, 26 May 2021 16:24:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id ECD5BDA70B; Wed, 26 May 2021 18:21:34 +0200 (CEST)
Date:   Wed, 26 May 2021 18:21:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Matthew Miller <mattdm@fedoraproject.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: BLAKE3 for Btrfs?
Message-ID: <20210526162134.GF7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Matthew Miller <mattdm@fedoraproject.org>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
References: <CAEg-Je-3pS3BCOv4xVoFeTRkH9ovs5RLn4OjqPWMoQnbHGA9RQ@mail.gmail.com>
 <afb9eba2-02c0-6b5c-8642-17b827c2a7cc@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afb9eba2-02c0-6b5c-8642-17b827c2a7cc@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 26, 2021 at 09:27:13AM +0300, Nikolay Borisov wrote:
> On 26.05.21 г. 8:51, Neal Gompa wrote:
> > I just read this article on BLAKE3 1.0 coming soon[1], and the
> > performance of BLAKE3 looks extremely compelling. With the context of
> > thinking about Btrfs authenticated hashes and fsverity[2], it seems
> > like it would make sense to see if BLAKE3 can provide us roughly
> > similar performance to xxhash or crc32. If so, that would make it
> > highly attractive for a new default hash, too[3].
> 
> Especially in the context of security I'd say we shouldn't be quick to
> jump on the bandwagon. Let the algorithm be ratified, let it simmer in
> the public for a while to see if any weakness are found and then we can
> consider adding it.

Agreed, this was the idea behind choosing BLAKE2 a few years after it
got adopted by other projects. In a ~five year horizon we can evaluate
the hashes again. Meanwhile I'd like to make some progress with the
authenticated hashes and for that we have enough to choose from.
