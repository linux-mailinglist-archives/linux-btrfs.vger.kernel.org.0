Return-Path: <linux-btrfs+bounces-4424-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BE18AAAAF
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 10:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27BCE1C22008
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 08:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A468269DF4;
	Fri, 19 Apr 2024 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+x0WNMu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24ED38D
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 08:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713516028; cv=none; b=C/1e294zwHXLUHt/+ldYd/RiV8j7147Xsg9hMfuArQ2UB2pleeVx0nZMM8J4pjXcPpyRIfWMz8hIPLbNxxmBI3Is0w5k0vajVGUT06tOAasSNFNxhTIaIRAKS7eQOo8XzfEwkGXoUF1xEYcn+m3gl5SsGf9Fkty5el/0zgEk7ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713516028; c=relaxed/simple;
	bh=8WS2jWbMl1JXBj3p7hR7u97Yj77JfzA7m1LB86Rhq/s=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject; b=AVJKOEpXahCq5iUnV3kDJAbr1XGlYIuDUp9VDpD2gjszQAQuPuKTaW+WTmd/+l0by9iI9LdSDlkBYcooao4NBz+u6vPonVjzzL9TY424KNL0qqXfKIIzsNHMiJKASjSYTEaHfXsfumDSScJEQlDkRRn2NAF/e4pLHc7eRLo6mSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+x0WNMu; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51ab4ee9df8so733691e87.1
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 01:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713516025; x=1714120825; darn=vger.kernel.org;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PBXAFKQ0catpcKf6qNAvx7Vp5rP3SIplMQFYpZsTcX8=;
        b=U+x0WNMu87B63kk2Hyhe1BIB8j9Q7aoxzTeiLWeeDyl9kYgiyKi4EPFnYzzHREPQlM
         7SjyDYmUzdjNAMpLwjYZQSiSVIwksp+IwRE2tCXLLS2cyXqzbB6WCFnwtfNn7JYUxgim
         EDbIvaLauXQjegR7VrqgH0Aa5uZeGpKVgLfR2Lcjmc38NvoGuWIOyRoXwP1IriVGYefP
         8dmEC4XNVV3Q5pFtKddgPzl+CzyJXOAJPQreAMdMMC7ePqkvNavQPkzxZU+0uWunIch1
         nlFAlUQB1k7zjvwhjUuAhCt0Lx3NAE8J3mTbXaE+xkOAlSzj7zO/0ZUvyX20999D16bW
         fjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713516025; x=1714120825;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PBXAFKQ0catpcKf6qNAvx7Vp5rP3SIplMQFYpZsTcX8=;
        b=qcXJfw6rWDgL4b+UVxqwiYha9ddVmEmiLStNmbFISYgv0ubZBgEjuc3oNIeJuy9M7A
         nIIuFD3Tuvv6k7yBl5SvwZGq7a9bllzTNt4FR1/ry7SHjN2rA7TKAIRlNaVYUFfr612g
         ZEw0lNLW5rfjSesQohJ7ZsSmbZ9vniVK2eVfUTy1UpqPe3GGknA6sAnbfnB2a07zoIfo
         pAY48EMS4vFb7VEDruuEcGZIXu2ACQMNb4xJTGV8JW7gglStpnNtTBBnJZbim4xxUnTr
         s5jAC+krjdJyOXngGOyYR/pBTPPfgpPFjpxAeucL6Nf5yaDJoJLqZ8zih6aRRqzr7Dsd
         6fbQ==
X-Gm-Message-State: AOJu0YxNg2WVxA/jSHKltklB4eD6e7AjcYlXQC8wn6XIXPRv3G3ncBG8
	dTBsVYPCSla3UC38LZsiAcKeaFMrXvJyiET0JZkl9AlZGfvl+m3M0ec6JpI5
X-Google-Smtp-Source: AGHT+IEJ67QPOotnQ0sGx2is8HXafzNLum8O1DhE7PxiBWVxeb0/xZOKH+23uJRJYexQJHcWm0x6/Q==
X-Received: by 2002:a05:6512:1319:b0:516:d250:86c4 with SMTP id x25-20020a056512131900b00516d25086c4mr1347556lfu.59.1713516024271;
        Fri, 19 Apr 2024 01:40:24 -0700 (PDT)
Received: from [192.168.5.235] ([109.195.103.195])
        by smtp.gmail.com with ESMTPSA id j18-20020a056512109200b0051acfb9cdadsm12259lfg.301.2024.04.19.01.40.23
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 01:40:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------wtAFwcjlzxJ06qNcoK85t0Gr"
Message-ID: <b996820e-efa5-4fb5-ba4e-57cc295c1b64@gmail.com>
Date: Fri, 19 Apr 2024 13:40:22 +0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: linux-btrfs@vger.kernel.org
From: Skirnir Torvaldsson <skirnir.torvaldsson@gmail.com>
Subject: support request: btrfs df reports drive is out of space, cannot find
 what occupies it

This is a multi-part message in MIME format.
--------------wtAFwcjlzxJ06qNcoK85t0Gr
Content-Type: multipart/alternative;
 boundary="------------WWDtgg7d4OQrIpjJsMABF4Q0"

--------------WWDtgg7d4OQrIpjJsMABF4Q0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear btrfs experts,

Could you please help me sort out the following situation:

btrfs df reports my 100Gb device is almost out of space (which agrees 
with the results produced by the standard "df"):

root@next:/home/support# btrfs fi df /
Data, single: total=82.00GiB, used=78.23GiB
System, DUP: total=32.00MiB, used=16.00KiB
Metadata, DUP: total=1.00GiB, used=153.70MiB
GlobalReserve, single: total=68.45MiB, used=0.00B
root@next:/home/support# df -h /
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda3        96G   79G   16G  84% /

However  when I try to locate files to delete with du that's what I get:

|root||@next||:/home/support# du -hd1 /|
|70M     /boot|
|0| |/dev|
|2||.2G /.snapshots|
|14M     /bin|
|4||.5M /etc|
|2||.5M /home|
|348M    /lib|
|4||.0K /lib64|
|0| |/media|
|0| |/mnt|
|0| |/opt|
|0| |/proc|
|40K     /root|
|2||.7M /run|
|12M     /sbin|
|0| |/srv|
|0| |/sys|
|0| |/tmp|
|566M    /usr|
|5||.0G /var|
|29G     /next|
|38G     /|
|
|
|I.e. almost 40Gb just gone somewhere. Am I doing something wrong? Is 
there a problem or a piece of theory I'm missing? Kindly advice.|
|
|
|+++++++++++++++++++++++++++++++++++++|
|root@next:~||#  uname -a|
|Linux next 5.10.0-28-amd64 ||#1 SMP Debian 5.10.209-2 (2024-01-31) 
x86_64 GNU/Linux|
|root@next:~||#  btrfs --version|
|btrfs-progs v5.10.1|
|root@next:~||#  btrfs fi show|
|Label: ||'NEXT_ROOTFS'| |uuid: abc71bdb-c570-461d-a28a-54294a646089|
|||Total devices 1 FS bytes used 78.37GiB|
|||devid    1 size 95.46GiB used 84.06GiB path ||/dev/sda3|
|root@next:~||#  btrfs fi df /|
|Data, single: total=82.00GiB, used=78.22GiB|
|System, DUP: total=32.00MiB, used=16.00KiB|
|Metadata, DUP: total=1.00GiB, used=153.64MiB|
|GlobalReserve, single: total=68.45MiB, used=0.00B|
|
|

--------------WWDtgg7d4OQrIpjJsMABF4Q0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Dear btrfs experts, <br>
    </p>
    <p>Could you please help me sort out the following situation:</p>
    <p>btrfs df reports my 100Gb device is almost out of space (which
      agrees with the results produced by the standard "df"):</p>
    <p>root@next:/home/support# btrfs fi df /<br>
      Data, single: total=82.00GiB, used=78.23GiB<br>
      System, DUP: total=32.00MiB, used=16.00KiB<br>
      Metadata, DUP: total=1.00GiB, used=153.70MiB<br>
      GlobalReserve, single: total=68.45MiB, used=0.00B<br>
      root@next:/home/support# df -h /<br>
      Filesystem      Size  Used Avail Use% Mounted on<br>
      /dev/sda3        96G   79G   16G  84% /</p>
    <p>However  when I try to locate files to delete with du that's what
      I get:</p>
    <div class="container" title="Hint: double-click to select code">
      <div class="line number1 index0 alt2" data-bidi-marker="true"><code
          class="java plain">root</code><code class="java color1">@next</code><code
          class="java plain">:/home/support# du -hd1 /</code></div>
      <div class="line number2 index1 alt1" data-bidi-marker="true"><code
          class="java plain">70M     /boot</code></div>
      <div class="line number3 index2 alt2" data-bidi-marker="true"><code
          class="java value">0</code>       <code class="java plain">/dev</code></div>
      <div class="line number4 index3 alt1" data-bidi-marker="true"><code
          class="java value">2</code><code class="java plain">.2G   
          /.snapshots</code></div>
      <div class="line number5 index4 alt2" data-bidi-marker="true"><code
          class="java plain">14M     /bin</code></div>
      <div class="line number6 index5 alt1" data-bidi-marker="true"><code
          class="java value">4</code><code class="java plain">.5M   
          /etc</code></div>
      <div class="line number7 index6 alt2" data-bidi-marker="true"><code
          class="java value">2</code><code class="java plain">.5M   
          /home</code></div>
      <div class="line number8 index7 alt1" data-bidi-marker="true"><code
          class="java plain">348M    /lib</code></div>
      <div class="line number9 index8 alt2" data-bidi-marker="true"><code
          class="java value">4</code><code class="java plain">.0K   
          /lib64</code></div>
      <div class="line number10 index9 alt1" data-bidi-marker="true"><code
          class="java value">0</code>       <code class="java plain">/media</code></div>
      <div class="line number11 index10 alt2" data-bidi-marker="true"><code
          class="java value">0</code>       <code class="java plain">/mnt</code></div>
      <div class="line number12 index11 alt1" data-bidi-marker="true"><code
          class="java value">0</code>       <code class="java plain">/opt</code></div>
      <div class="line number13 index12 alt2" data-bidi-marker="true"><code
          class="java value">0</code>       <code class="java plain">/proc</code></div>
      <div class="line number14 index13 alt1" data-bidi-marker="true"><code
          class="java plain">40K     /root</code></div>
      <div class="line number15 index14 alt2" data-bidi-marker="true"><code
          class="java value">2</code><code class="java plain">.7M   
          /run</code></div>
      <div class="line number16 index15 alt1" data-bidi-marker="true"><code
          class="java plain">12M     /sbin</code></div>
      <div class="line number17 index16 alt2" data-bidi-marker="true"><code
          class="java value">0</code>       <code class="java plain">/srv</code></div>
      <div class="line number18 index17 alt1" data-bidi-marker="true"><code
          class="java value">0</code>       <code class="java plain">/sys</code></div>
      <div class="line number19 index18 alt2" data-bidi-marker="true"><code
          class="java value">0</code>       <code class="java plain">/tmp</code></div>
      <div class="line number20 index19 alt1" data-bidi-marker="true"><code
          class="java plain">566M    /usr</code></div>
      <div class="line number21 index20 alt2" data-bidi-marker="true"><code
          class="java value">5</code><code class="java plain">.0G   
          /var</code></div>
      <div class="line number22 index21 alt1" data-bidi-marker="true"><code
          class="java plain">29G     /next</code></div>
      <div class="line number23 index22 alt2" data-bidi-marker="true"><code
          class="java plain">38G     /</code></div>
      <div class="line number23 index22 alt2" data-bidi-marker="true"><code
          class="java plain"><br>
        </code></div>
      <div class="line number23 index22 alt2" data-bidi-marker="true"><code
          class="java plain">I.e. almost 40Gb just gone somewhere. Am I
          doing something wrong? Is there a problem or a piece of theory
          I'm missing? Kindly advice.</code></div>
      <div class="line number23 index22 alt2" data-bidi-marker="true"><code
          class="java plain"><br>
        </code></div>
      <div class="line number23 index22 alt2" data-bidi-marker="true"><code
          class="java plain">+++++++++++++++++++++++++++++++++++++</code></div>
      <div class="line number23 index22 alt2" data-bidi-marker="true">
        <div class="container" title="Hint: double-click to select code">
          <div class="line number1 index0 alt2" data-bidi-marker="true"><code
              class="bash plain">root@next:~</code><code
              class="bash comments">#  uname -a</code></div>
          <div class="line number2 index1 alt1" data-bidi-marker="true"><code
              class="bash plain">Linux next 5.10.0-28-amd64 </code><code
              class="bash comments">#1 SMP Debian 5.10.209-2
              (2024-01-31) x86_64 GNU/Linux</code></div>
          <div class="line number3 index2 alt2" data-bidi-marker="true"><code
              class="bash plain">root@next:~</code><code
              class="bash comments">#  btrfs --version</code></div>
          <div class="line number4 index3 alt1" data-bidi-marker="true"><code
              class="bash plain">btrfs-progs v5.10.1</code></div>
          <div class="line number5 index4 alt2" data-bidi-marker="true"><code
              class="bash plain">root@next:~</code><code
              class="bash comments">#  btrfs fi show</code></div>
          <div class="line number6 index5 alt1" data-bidi-marker="true"><code
              class="bash plain">Label: </code><code
              class="bash string">'NEXT_ROOTFS'</code>  <code
              class="bash plain">uuid:
              abc71bdb-c570-461d-a28a-54294a646089</code></div>
          <div class="line number7 index6 alt2" data-bidi-marker="true"><code
              class="bash spaces">        </code><code
              class="bash plain">Total devices 1 FS bytes used 78.37GiB</code></div>
          <div class="line number8 index7 alt1" data-bidi-marker="true"><code
              class="bash spaces">        </code><code
              class="bash plain">devid    1 size 95.46GiB used 84.06GiB
              path </code><code class="bash plain">/dev/sda3</code></div>
          <div class="line number9 index8 alt2" data-bidi-marker="true"> </div>
          <div class="line number10 index9 alt1" data-bidi-marker="true"><code
              class="bash plain">root@next:~</code><code
              class="bash comments">#  btrfs fi df /</code></div>
          <div class="line number11 index10 alt2"
            data-bidi-marker="true"><code class="bash plain">Data,
              single: total=82.00GiB, used=78.22GiB</code></div>
          <div class="line number12 index11 alt1"
            data-bidi-marker="true"><code class="bash plain">System,
              DUP: total=32.00MiB, used=16.00KiB</code></div>
          <div class="line number13 index12 alt2"
            data-bidi-marker="true"><code class="bash plain">Metadata,
              DUP: total=1.00GiB, used=153.64MiB</code></div>
          <div class="line number14 index13 alt1"
            data-bidi-marker="true"><code class="bash plain">GlobalReserve,
              single: total=68.45MiB, used=0.00B</code></div>
        </div>
      </div>
      <div class="line number23 index22 alt2" data-bidi-marker="true"><code
          class="java plain"><br>
        </code></div>
    </div>
    <p></p>
  </body>
</html>

--------------WWDtgg7d4OQrIpjJsMABF4Q0--
--------------wtAFwcjlzxJ06qNcoK85t0Gr
Content-Type: application/x-gzip; name="dmesg.log.gz"
Content-Disposition: attachment; filename="dmesg.log.gz"
Content-Transfer-Encoding: base64

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
AyLhlSvNLgIA

--------------wtAFwcjlzxJ06qNcoK85t0Gr--

