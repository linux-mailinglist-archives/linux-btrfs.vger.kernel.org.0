Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6EA9A9231
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 21:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388032AbfIDTHR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 15:07:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34843 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731778AbfIDTHQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Sep 2019 15:07:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id n10so5084580wmj.0
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Sep 2019 12:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0UVmnp4aAKCdi1MURsL39WoXD27IuZRhOEIrb/pWKrQ=;
        b=hoHXal8qSYokh2CHHnMqCilW6tgh+xg6q8EYOg/BjSp51t+vZE0PebmsSiDsH6xpbE
         iAMmcM/k69eEbOdbWWN/7FTyvbcjsJvlI1hRANlmnQNWD3TF9MxdabLS/gq/Y5Py//hW
         NsK05SxVpZOUr7H6M5JCTBzujyL9aBWK/GVyhZu/DGmZAtMmxMv9xUpxFgWKwXHOBaCP
         iuWuqIzaS3F57Il39058lAFXcwq/AnTvLu/W0/PdSKf4jW9V53bdWyumVnReWnAvVGN2
         GjddT7AvxiGs7Dx9t4wdPt4bYqEwDpaThzNx+8J56M2LlL1WRguX2zbnkGs9F5RZ4eS4
         eozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0UVmnp4aAKCdi1MURsL39WoXD27IuZRhOEIrb/pWKrQ=;
        b=AK4ELnQjYuGD238SWsrs7e+AWg4ncJNgAoZeK2U88TEREUflGBi6v7JldU6uFyToIW
         n84gisyHwznOupYEDl8NTeA7bMuMO3L6lWC1fzKMn5xiwopojzib5h+h1wpw7W4on2HK
         RxijJ0Xl+y/p1tAPAkcqzkdbDn+3eP8GCl6Qr9GkoPi6GRNdTwT/hayIkYN5zZn+zj2E
         O9xnSyXfNOw/Gzq+AjojCPi1fsz+1PvmRXkcK7t8sjdEgkcdZD2BcBcNVRhOgDkM5p/L
         HIlDCc6W1y0iJksUrDA6+zfvHf9vzzxdH0OzP/8gvzIptTTRcigsBVweneB/O/rwfCy1
         HOkA==
X-Gm-Message-State: APjAAAVek3Pn3xywn+iWyKVuj2pBU+yncp7/5YLtM7nZ6usTg8asgSsZ
        JDhWaQvHna1zH7rlsFXfjgxie/L8AXmjtyaPmFqFj0crNPE=
X-Google-Smtp-Source: APXvYqzt4BQj8hiHpkfLCtyXqc2eykh0oc85XA0zKCemDAj9TnOK3t64Gz6+VdabbYRQVP7x4aMtArfgPTvyBIeFkLo=
X-Received: by 2002:a1c:e709:: with SMTP id e9mr5818065wmh.65.1567624034579;
 Wed, 04 Sep 2019 12:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <b729e524-3c63-cf90-7115-02dcf2fda003@gmail.com>
 <CAJCQCtTs4jBw_mz3PqfMAhuHci+UxjtMNYD7U4LJtCoZxgUdCg@mail.gmail.com>
 <f22229eb-ab68-fecb-f10a-6e40c0b0e1ef@gmail.com> <CAJCQCtRPUi3BLeSVqELopjC7ZvihOBi321_nxqcUG1jpgwq9Ag@mail.gmail.com>
 <423454bc-aa78-daba-d217-343e266c15ee@georgianit.com>
In-Reply-To: <423454bc-aa78-daba-d217-343e266c15ee@georgianit.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 4 Sep 2019 13:07:03 -0600
Message-ID: <CAJCQCtSG9W93dWwH7++dBGh94s6UGGbugrW8y17OmycC5wP8kw@mail.gmail.com>
Subject: Re: No files in snapshot
To:     Remi Gauvin <remi@georgianit.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 4, 2019 at 12:24 PM Remi Gauvin <remi@georgianit.com> wrote:
>
> On 2019-09-04 1:36 p.m., Chris Murphy wrote:
>
> >>
> >
> > I don't really know how snapper works.
> >
> > The way 'btrfs subvolume snapshot' works,  you must point it to a
> > subvolume. It won't snapshot a regular directory and from what you
> > posted above, there are no subvolumes in /var or /var/lib which means
> > trying to snapshot /var/lib/ceph/osd/ceph-....  would fail. So maybe
> > it's failing but snapper doesn't show the error. I'm not really sure.
> >
>
> In this case, his snapshots are all of the root.
>
> I don't know how Ceph works, but since we already confirmed that there
> are no subvolumes under /var, the only other explanation is that
> /var/lib/ceph/osd/ceph-<n> is a submount
>
> What is the the result of running:
> mount | grep /var
>

Yep.


-- 
Chris Murphy
