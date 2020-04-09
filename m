Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03B5F1A2CCC
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Apr 2020 02:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgDIASL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Apr 2020 20:18:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34085 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgDIASL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Apr 2020 20:18:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id 65so9759100wrl.1
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Apr 2020 17:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eva/cAV7rknyuvfXn1VWNiGlyHh3lPKZoIKlSWsCftc=;
        b=FJBQXYgf58T11Z0YGXZtc/sHqD3wK6BEohbugW01cssV0qw4Pbx7aJoZJX8cX57IjV
         06QcmZpXArl1KTa06DBb/KNBmmYfjczpQfVHkZAJ2PktFGoRK4m/eSiL35zp6mFmW5Bo
         zQPzgv3WA5yA2LN6LVRH0aEzydCgdYrpkzGMqQzh1hn+/u9gq/rYrLodlMSVyOEUQXmA
         GCLsS2v3TJxHS4x3fv6csPagu13xOWjkOT1uhWkiKda5rSfawQkX0GqCuvHHWYyTEcdp
         WV/9BoE5Mzzpm4KVF6AYwhex8/GlO2+JrO3kSKD0UA/QgAqdVq4wXJMgSE/tENPDCf89
         JwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eva/cAV7rknyuvfXn1VWNiGlyHh3lPKZoIKlSWsCftc=;
        b=famSeusd8qapvST0L5fAJ83pSiR2Zwy4F7uLFaG93wW32Oc4yND8m7bAsM5NG5KhSp
         EMdoM98ivcsLOhHnypGbfac8xwnXuqolcbWusqIzN5VDLMazEBLUpY5cyuDSIODC5LoX
         9KfiovJuPt7W9anu1ZCOj2CIGhkSQ51uO59JRjknIHzmv/Xqn4rfOX8hF63z0KXhpjIu
         611Z/CBtDmQiOWy5oy2urwERhw9mrw2djZr9nEhPi8AALyXgIlxbDfaahtnBF8Z2LV30
         NrpLH1SpwVIRhBaIspnHoQGDXF1pMUDD3bCIsdY1ll87usX3WmdcunVH2gHz6CSu3PY1
         B7pw==
X-Gm-Message-State: AGi0PuYcMZWQfhRm4MVzbvA0oscRDtUlSR2K+wzhWQhg3z6EZ6YaRzmg
        3G+ZygubSUMIkD1vpAcofUSmDD7gYyYfY15KYq+gpQ==
X-Google-Smtp-Source: APiQypIipGkJmsGJ3PcVY7/F3i6AiXPDhqenNLj+Zfn5EO9cBhunoylVau8xmUDKmSaczbqPZhMID+oBVfYO3YORtWo=
X-Received: by 2002:a5d:45cf:: with SMTP id b15mr10772817wrs.274.1586391489895;
 Wed, 08 Apr 2020 17:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtSLOgj7MHKNeGOHu1DPa=xC=sR7cZzR88hN1y_mTYRFKw@mail.gmail.com>
 <SN4PR0401MB35987317CD0E2B97CD5A499E9BC00@SN4PR0401MB3598.namprd04.prod.outlook.com>
In-Reply-To: <SN4PR0401MB35987317CD0E2B97CD5A499E9BC00@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 8 Apr 2020 18:17:53 -0600
Message-ID: <CAJCQCtRtxqy7eMPg+eWoz36MMNBM48-mec8h182p4HmQqX-48Q@mail.gmail.com>
Subject: Re: authenticated file systems using HMAC(SHA256)
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 8, 2020 at 5:17 AM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 07/04/2020 20:02, Chris Murphy wrote:
> > Hi,
> >
> > What's the status of this work?
> > https://lore.kernel.org/linux-btrfs/20191015121405.19066-1-jthumshirn@suse.de/
>
> It's done but no-one was interested in it and as I haven't received any
> answers from Dave if he's going to merge it, I did not bring it to
> attention again. After all it was for a specific use-case SUSE has/had
> and I left the company.

I'm thinking of a way to verify that a non-encrypted generic
boot+startup data hasn't been tampered with. That is, a generic,
possibly read-only boot, can be authenticated on the fly. Basically,
it's fs-verity for Btrfs, correct?

Other use cases?


> If there is still interest in this work I can re-base my branches [1][2]
> and add blake2b as well, this /should/ be trivially done.
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/jth/linux.git/log/?h=btrfs-integrity
> [2] https://github.com/morbidrsa/btrfs-progs/tree/mkfs-hmac

I think 'btrfs check' also needs to be fed the hmac in order to verify
checksums and also rewrite out a new csum or extent tree and do
repairs?

> I just don't want to spend time on it again when it's not going to be
> merged in the end (for what ever reason).

Sure. Seems reasonable.

-- 
Chris Murphy
