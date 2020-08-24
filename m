Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE5924F2F1
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 09:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgHXHOc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 03:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgHXHOa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 03:14:30 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A876C061573
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 00:14:30 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id c19so5504323wmd.1
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 00:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RdfWzFt0bUrONSBmvtOrelgFLUbfEUl2sWpsj2e5mY4=;
        b=n3Rc3VqkhW+fQp3S9J8TNBuwIKRuC9/hfgmZI0AG8+iARIv9iqQ+7c8pFUCrOtRPnJ
         boIJkB5qHJovCQz2yWv6PaAon/T2fuaqbbmrJ3LVRFNnoFBoiUK5VuO2GepeestYPaZM
         F1GrQsz3Oyydstgp5gPLmY1LTdNJo4TXPhXKCaJVQR4+xy81qQQidL97wvM2qZ8sOUF9
         R7HNRLwXu2qCVXrG01P5nd/9wuqfDi+uzn1xewBWpks2VEHXV1VvfNs2RtxzY97evv7L
         ivm0er8h/O3IeTMNcUrAJl4bSckSxF7gHFH7l8JWbic1/PT4edDBviR2dZdpB3DBV6a2
         dRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RdfWzFt0bUrONSBmvtOrelgFLUbfEUl2sWpsj2e5mY4=;
        b=LCDyl+TccGmCdOFFRVOsDvGTs3rociznWOryR5IwyDzm4bNBskGl30Feqb+zwgWh5j
         B78dydcwxzRMNtF7+OwrJ69witMxPUL7JQwcBJajazExWM+FniEJN5XPNVTcN+SOoT7l
         jjrhrq7Har0qZ8j07j5WB/Gjw2IwGt9tYmiiFtH6HlL7CYV55x+87aButerQDYIq3BOh
         LFbZFEvWyGXihJ40u96/fYux7YvQcRgnUmCSgw4cZ2LFyTGwifowfmvDHLejyoOJUDjq
         k0plw/iW3q2w3Gbuwtnti3i+vjCeMb2vIcxtVcgGRRvcsiSg8LBPlX0gP2xrBrrkZOS5
         KMVw==
X-Gm-Message-State: AOAM531PM3wAKMrZRSCeyYlxEwndtQA2gAv8YLJpvFmSwQsO2FgQniPy
        exWIBn7Fs+2QPCzp05Hl9RFjDHSLQITz5+ZMhMsfGA==
X-Google-Smtp-Source: ABdhPJzi+AgigA6eLlmEhNEqOoGX7Pf1euzx13PDnakojxjdZRMumjjCA0zCjb1XO+SgtEjZcTghchC8cyXnbVFI8H8=
X-Received: by 2002:a7b:cf0b:: with SMTP id l11mr4201909wmg.128.1598253269120;
 Mon, 24 Aug 2020 00:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com>
 <CAJCQCtTC2yi4HRqg6fkMrxw33TVSBh_yAKtnX-Z1-nXSVjBW7w@mail.gmail.com> <Yy8-04dbNru1LWPcNZ9UxsagH1b0KNsGn7tDEnxVOqS812IqGiwl37dj4rxAh05gEP8QoNJ5F_Ea6CZ8iZgvnupuq5Qzc38gl69MceWMc9s=@protonmail.com>
In-Reply-To: <Yy8-04dbNru1LWPcNZ9UxsagH1b0KNsGn7tDEnxVOqS812IqGiwl37dj4rxAh05gEP8QoNJ5F_Ea6CZ8iZgvnupuq5Qzc38gl69MceWMc9s=@protonmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 24 Aug 2020 01:13:47 -0600
Message-ID: <CAJCQCtSqe_oqRZWYP7iLJcGQnzZkC4vmoYVTm_9RPb8eb0-E6Q@mail.gmail.com>
Subject: Re: [Help] Can't login to my systemd-homed user account due to
 fallocate failure
To:     Andrii Zymohliad <azymohliad@protonmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Andrei Borzenkov <arvidjaar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 24, 2020 at 12:12 AM Andrii Zymohliad
<azymohliad@protonmail.com> wrote:
>
> Hello Chris! Thanks a lot for so many ideas, I updated this snippet with =
most of the commands you asked the output for: https://gitlab.com/-/snippet=
s/2007189, more details inline.

>> # ls -lhs /home/azymohliad.home
>>    257G -rw------- 1 root root 403G =D1=81=D0=B5=D1=80 23 18:20 /home/az=
ymohliad.home

OK so it's a sparse file..


> This one is 18k lines, uploaded here: https://gitlab.com/-/snippets/20073=
01

There are many shared extents, so it has been subject to snapshot,
reflink copy, or dedup.

To my knowledge, sd-homed doesn't do any of these things. Something
else did it. Are you using snapper or timeshift? Have you used 'cp' to
duplicate the home backing file?

What do you get for

lsattr /home/azymohliad.home

> Idk, I guess it's better to go back to Systemd mailing list for that, but=
 just in case I've added "homectl inspect azymohliad" output to the gitlab =
snippet. Here's what it says about discard:
>
>     LUKS Discard: online=3Dno offline=3Dyes

I'm not sure what it means, but I'll ask on systemd list.

> Here is the btrfs-debugfs output: https://gitlab.com/-/snippets/2007302

OK too late, it's already been balanced.

I think we've got a pretty good idea what's going on. The current work
around in your case will be to use the --luks-discard=3Dtrue option when
activating. This will avoid the fallocate step. But the question
remains why the fallocate fails. I suspect it has something to do with
shared extents. Somewhere you have one or more snapshots containing
this home file. And that's causing some confusion.


--=20
Chris Murphy
