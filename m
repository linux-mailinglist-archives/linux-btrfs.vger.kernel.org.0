Return-Path: <linux-btrfs+bounces-9623-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C279C7E2D
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 23:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A450F284449
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 22:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12E918BC32;
	Wed, 13 Nov 2024 22:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I99BUHTU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE94C187FEC
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 22:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731536473; cv=none; b=VCPJcDgTbMaNvOYSBzB1libcKPTOFbOV5PwH1rYaKuNtL6EWgGCpdwOTrXEW/3u9nc6RvrRIJKrdFSxVfm3Vn0NKwv/KsXfgYmSWtJihpU0Q8i+Ee3HGH5mC/0bm2iRjCwoidLesDi1tRqbAe+M+S0OLFEuBe2so5mq15AEqagE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731536473; c=relaxed/simple;
	bh=A1z4jo6hJSVMFWNPOkjhbanItOfMVAowriGZHJXvk5E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=tSDTuFbf0882i9yKgGr7siKXO8PrL0ZiUG/OzFSOoxPJesApTRFT0gGczFzpyRx2EL/hRnhm1z9spRH+Y/7ETKO5SyRWUQAJLDX3f5Cin6J1sJpHqdcsFwmzKNYULFjgn+OlQKZBP2Hzb5eCmGIA36VJ4oXYOGs5uSOLZtcAd9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I99BUHTU; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e59dadebso8714956e87.0
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 14:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731536467; x=1732141267; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rkU0bnlQtH3plSmfgtc5Q4JtKNN3ujNKmxB5wj8IK4c=;
        b=I99BUHTUaZpL1LgT87K/vXGUFw9qT4ybcDkEJFiUbbJXkF+R4JCvnuOO8MtG/E+Loq
         Caoxe6sQWCX1mYGwzDF2aQCkAPxzXO8KWZnz5DSJFsNC41DVc6foohZ8eTkyB8tmT/+l
         qirMMXxrPCypqMFGJWuSEtORMOXCSYq5M47zOrhNLF4OtH1Kxw0xLrfkanB8/rPtqhMC
         0S59eaNtPopcenaaLQ7smXOoEwSbqxn0zxGYiejyIyD6YUopLl+NZ1lU9zIsaETTekQJ
         WDqvGdVmSuhmddMyhh+dE8xaYS1rXxJXOVlyoNt0XEFiqNixpncfsXbqzUlwxOROXKey
         6RQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731536467; x=1732141267;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rkU0bnlQtH3plSmfgtc5Q4JtKNN3ujNKmxB5wj8IK4c=;
        b=CmoCK+/nolavRmvUMgd1kLZkH7AiymOQ98PUtm1yWpKJ0LPs8RkH/XJnKgOjhkF/J4
         N2fg8APHthA4oBDwFHSnilaE9j83+84plk/eP3dvk3USLUg2Lx3cllAz9uNe5rAX/+IV
         mC390KO7Jw4bTfoa3WgkZoEzN+Sz0TBJzKIME3PaTxX+yaHZmWL4caVVMZzNeqgBPJIb
         hYpdfI0qJEo3Zx8Q2sFyCD+zBpEF7hn/eturEWZu1YmMhVkafKFFc9x6zAIELld2dUdP
         XHRXWC5sbFI4wI0yzWKgCD7EUo3l1gaC5nEeCyBAYMPxGKj8Vrcp66Cueo8H8Mwhcz57
         fYSA==
X-Gm-Message-State: AOJu0Yx9E/qYwzz+Cgu6NUHTI8yhNzOPZSf2y3Gw+7h/oC2b62AIgMW8
	QJ+Ltb9At4iKj/4wlDIsaKHKSVrAjrykZCZ2tcUy6YWSbWUY7pkjNrELmfeLnieZ0aws2G9Iu8J
	L7Yes48XufiZajhAXUtnSivEcybC/UFm1
X-Google-Smtp-Source: AGHT+IFVQrq2dfRuI/Sx5CM5XWghTPRMvgvojXasQgWr9VZmRHd4P1x/dFNzmHkxS6AqsYHbA9bVbgMbCalwY4wpIpI=
X-Received: by 2002:a05:6512:2341:b0:53d:a596:2d24 with SMTP id
 2adb3069b0e04-53da5962d5emr38562e87.44.1731536466626; Wed, 13 Nov 2024
 14:21:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zac Medico <zmedico@gmail.com>
Date: Wed, 13 Nov 2024 14:20:53 -0800
Message-ID: <CAMiTYSrjvnPMG5MyqGZtMVqsukkapZ4P4Kh8tveHn63USVNd9Q@mail.gmail.com>
Subject: 
To: linux-btrfs@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000000270200626d2c02d"

--0000000000000270200626d2c02d
Content-Type: text/plain; charset="UTF-8"

unsubscribe linux-btrfs

--0000000000000270200626d2c02d
Content-Type: message/rfc822; 
	name="[aio-libs/aiohttp] Release v3.11.0 - 3.11.0.eml"
Content-Disposition: attachment; 
	filename="[aio-libs/aiohttp] Release v3.11.0 - 3.11.0.eml"
Content-Transfer-Encoding: 8bit
Content-ID: <f_m3gg30lf0>
X-Attachment-Id: f_m3gg30lf0

Delivered-To: zmedico@gmail.com
Received: by 2002:a05:6022:311f:b0:60:aee6:f2a1 with SMTP id e31csp482186laa;
        Wed, 13 Nov 2024 09:30:54 -0800 (PST)
X-Forwarded-Encrypted: i=2; AJvYcCVtJc/jV3YDa/E3qWK/d3kAo7uMGxmKVmf2yhVGCi60ppCwAPzn8Ft8Owo2FochYqhLIGRAf+k1@gmail.com
X-Google-Smtp-Source: AGHT+IEnaNCMDwOurMWtdpEJd35uzB/5kPrGDGrjeARkqdaPqicIGBVt87P2TKqHQa2UNBE18/gx
X-Received: by 2002:a05:600c:c08:b0:42c:bd27:4c12 with SMTP id 5b1f17b1804b1-432d4aae6b7mr39764335e9.10.1731519054175;
        Wed, 13 Nov 2024 09:30:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1731519054; cv=none;
        d=google.com; s=arc-20240605;
        b=dJmLClh60wHNEgLFc0jBWAaNUAqyIob05d1xAGGsWPMq8rJH5lZH7ngCWUiiyG1XIU
         bz5mK6yY/WzbPfNc+St+lk2hMVrb81p/9HiffND1fjAtxlKip/n+m4F0ehbxQSjsz4Sm
         3K93dvaYACCauNS8E38fbKAzGm4tztae+wECCMtWtWM91hqmDATWJtEm0bZB1kTxwdfg
         kkS0gstXPHQp7OBaaS9HZxvUV9k85/qH6nMewar5de0QSqo7wDq2iXTFfLA0qja+bEXW
         EqD2vDvYC/HpujTvgw9j49qNUeTnDkKjSqA3UjQzciIb0LmEHylpjoMjhyh2x/5rk7JA
         aRww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=destinations:list-post:list-archive:list-id:precedence
         :content-transfer-encoding:mime-version:subject:message-id:cc:to
         :reply-to:from:date:dkim-signature;
        bh=rzf5Q8GIUn/hxk0e3BIpA8GcF8Q70n53hq9akq5kYD8=;
        fh=oD1rP32H+BZVJQsia1dtln0EdxRUYY/yi7XXVHnlfMw=;
        b=lwDtv1SV638c+yavCUWnl/x+j3hnu/fk33hOLcNWc3VGDWZLtd/tWwg3YWnrgwiEXq
         zbJjeevD7GGXslHeZ1h0kPwWa+1CK9gtvqaEHL7Scv29oZbI21ZPiR+vRt8M7NNIMVKm
         CtxqSVyCwCvuxw3lUdbgqEomM3woC3Po5ljAgIinzT2klCdOg7gFQYE1//2LqWdwS+SE
         TloVf8jgJ5yknfVVkCKqFPzt5NzyAwamIW9DfNGqvWUuVFz6daaZeksRF++ka2t8jqKF
         KyBmQ7w2BaYHplKTEVEhaYUa8eDtDbk7kFodMdZ6B8Xx3ysJyy8gBucWZ9jE5NE1A+Ba
         B/rw==;
        dara=google.com
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@github.com header.s=pf2023 header.b=I2DtPxbD;
       spf=pass (google.com: domain of noreply@github.com designates 192.30.252.210 as permitted sender) smtp.mailfrom=noreply@github.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=github.com
Return-Path: <noreply@github.com>
Received: from out-27.smtp.github.com (out-27.smtp.github.com. [192.30.252.210])
        by mx.google.com with ESMTPS id 5b1f17b1804b1-432d554e374si12852375e9.167.2024.11.13.09.30.53
        for <zmedico@gmail.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:30:54 -0800 (PST)
Received-SPF: pass (google.com: domain of noreply@github.com designates 192.30.252.210 as permitted sender) client-ip=192.30.252.210;
Authentication-Results: mx.google.com;
       dkim=pass header.i=@github.com header.s=pf2023 header.b=I2DtPxbD;
       spf=pass (google.com: domain of noreply@github.com designates 192.30.252.210 as permitted sender) smtp.mailfrom=noreply@github.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=github.com
Received: from github.com (hubbernetes-node-7086411.ash1-iad.github.net [10.56.164.42])
	by smtp.github.com (Postfix) with ESMTPA id 78466601177
	for <zmedico@gmail.com>; Wed, 13 Nov 2024 09:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1731519053;
	bh=rzf5Q8GIUn/hxk0e3BIpA8GcF8Q70n53hq9akq5kYD8=;
	h=Date:From:Reply-To:To:Cc:Subject:List-ID:List-Archive:List-Post:
	 From;
	b=I2DtPxbDVNIPFcvWKY5FXHf0j8IKS+SwjvI6g79x7Dv+yziIale87mm+vv66mciRi
	 pOwDtHz+UNHef0cnBAyW671HkTab2q0X+CFfCCa4PT7Wh/dvhbNIydzh2lDSMWbIJX
	 QKr/rae189jUf6lHQzxOmFd7oTzTX161yUE4giEs=
Date: Wed, 13 Nov 2024 09:30:53 -0800
From: "github-actions[bot]" <notifications@github.com>
Reply-To: aio-libs/aiohttp <noreply@github.com>
To: aio-libs/aiohttp <aiohttp@noreply.github.com>
Cc: Subscribed <subscribed@noreply.github.com>
Message-ID: <aio-libs/aiohttp/releases/185247657@github.com>
Subject: [aio-libs/aiohttp] Release v3.11.0 - 3.11.0
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="--==_mimepart_6734e24d746d5_67193c956bf";
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: list
X-GitHub-Sender: github-actions[bot]
X-GitHub-Recipient: zmedico
X-GitHub-Reason: subscribed
List-ID: aio-libs/aiohttp <aiohttp.aio-libs.github.com>
List-Archive: https://github.com/aio-libs/aiohttp
List-Post: <mailto:noreply@github.com>
X-Auto-Response-Suppress: All
destinations: zmedico@gmail.com
X-GitHub-Recipient-Address: zmedico@gmail.com


----==_mimepart_6734e24d746d5_67193c956bf
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit

Bug fixes
---------

- Raise :exc:`aiohttp.ServerFingerprintMismatch` exception on client-side if request through http proxy with mismatching server fingerprint digest: `aiohttp.ClientSession(headers=headers, connector=TCPConnector(ssl=aiohttp.Fingerprint(mismatch_digest), trust_env=True).request(...)` -- by :user:`gangj`.


  *Related issues and pull requests on GitHub:*
  #6652.



- Modified websocket :meth:`aiohttp.ClientWebSocketResponse.receive_str`, :py:meth:`aiohttp.ClientWebSocketResponse.receive_bytes`, :py:meth:`aiohttp.web.WebSocketResponse.receive_str` & :py:meth:`aiohttp.web.WebSocketResponse.receive_bytes` methods to raise new :py:exc:`aiohttp.WSMessageTypeError` exception, instead of generic :py:exc:`TypeError`, when websocket messages of incorrect types are received -- by :user:`ara-25`.


  *Related issues and pull requests on GitHub:*
  #6800.



- Made ``TestClient.app`` a ``Generic`` so type checkers will know the correct type (avoiding unneeded ``client.app is not None`` checks) -- by :user:`Dreamsorcerer`.


  *Related issues and pull requests on GitHub:*
  #8977.



- Fixed the keep-alive connection pool to be FIFO instead of LIFO -- by :user:`bdraco`.

  Keep-alive connections are more likely to be reused before they disconnect.


  *Related issues and pull requests on GitHub:*
  #9672.




Features
--------

- Added ``strategy`` parameter to :meth:`aiohttp.web.StreamResponse.enable_compression`
  The value of this parameter is passed to the :func:`zlib.compressobj` function, allowing people
  to use a more sufficient compression algorithm for their data served by :mod:`aiohttp.web`
  -- by :user:`shootkin`


  *Related issues and pull requests on GitHub:*
  #6257.



- Added ``server_hostname`` parameter to ``ws_connect``.


  *Related issues and pull requests on GitHub:*
  #7941.



- Exported :py:class:`~aiohttp.ClientWSTimeout` to top-level namespace -- by :user:`Dreamsorcerer`.


  *Related issues and pull requests on GitHub:*
  #8612.



- Added ``secure``/``httponly``/``samesite`` parameters to ``.del_cookie()`` -- by :user:`Dreamsorcerer`.


  *Related issues and pull requests on GitHub:*
  #8956.



- Updated :py:class:`~aiohttp.ClientSession`'s auth logic to include default auth only if the request URL's origin matches _base_url; otherwise, the auth will not be included -- by :user:`MaximZemskov`


  *Related issues and pull requests on GitHub:*
  #8966, #9466.



- Added ``proxy`` and ``proxy_auth`` parameters to :py:class:`~aiohttp.ClientSession` -- by :user:`meshya`.


  *Related issues and pull requests on GitHub:*
  #9207.



- Added ``default_to_multipart`` parameter to ``FormData``.


  *Related issues and pull requests on GitHub:*
  #9335.



- Added :py:meth:`~aiohttp.ClientWebSocketResponse.send_frame` and :py:meth:`~aiohttp.web.WebSocketResponse.send_frame` for WebSockets -- by :user:`bdraco`.


  *Related issues and pull requests on GitHub:*
  #9348.



- Updated :py:class:`~aiohttp.ClientSession` to support paths in ``base_url`` parameter.
  ``base_url`` paths must end with a ``/``  -- by :user:`Cycloctane`.


  *Related issues and pull requests on GitHub:*
  #9530.



- Improved performance of reading WebSocket messages with a Cython implementation -- by :user:`bdraco`.


  *Related issues and pull requests on GitHub:*
  #9543, #9554, #9556, #9558, #9636, #9649, #9781.



- Added ``writer_limit`` to the :py:class:`~aiohttp.web.WebSocketResponse` to be able to adjust the limit before the writer forces the buffer to be drained -- by :user:`bdraco`.


  *Related issues and pull requests on GitHub:*
  #9572.



- Added an :attr:`~aiohttp.abc.AbstractAccessLogger.enabled` property to :class:`aiohttp.abc.AbstractAccessLogger` to dynamically check if logging is enabled -- by :user:`bdraco`.


  *Related issues and pull requests on GitHub:*
  #9822.




Deprecations (removal in next major release)
--------------------------------------------

- Deprecate obsolete `timeout: float` and `receive_timeout: Optional[float]` in :py:meth:`~aiohttp.ClientSession.ws_connect`. Change default websocket receive timeout from `None` to `10.0`.


  *Related issues and pull requests on GitHub:*
  #3945.




Removals and backward incompatible breaking changes
---------------------------------------------------

- Dropped support for Python 3.8 -- by :user:`Dreamsorcerer`.


  *Related issues and pull requests on GitHub:*
  #8797.



- Increased minimum yarl version to 1.17.0 -- by :user:`bdraco`.


  *Related issues and pull requests on GitHub:*
  #8909, #9079, #9305, #9574.



- Removed the ``is_ipv6_address`` and ``is_ip4_address`` helpers are they are no longer used -- by :user:`bdraco`.


  *Related issues and pull requests on GitHub:*
  #9344.



- Changed ``ClientRequest.connection_key`` to be a `NamedTuple` to improve client performance -- by :user:`bdraco`.


  *Related issues and pull requests on GitHub:*
  #9365.



- ``FlowControlDataQueue`` has been replaced with the ``WebSocketDataQueue`` -- by :user:`bdraco`.


  *Related issues and pull requests on GitHub:*
  #9685.



- Changed ``ClientRequest.request_info`` to be a `NamedTuple` to improve client performance -- by :user:`bdraco`.


  *Related issues and pull requests on GitHub:*
  #9692.




Packaging updates and notes for downstreams
-------------------------------------------

- Switched to using the :mod:`propcache <propcache.api>` package for property caching
  -- by :user:`bdraco`.

  The :mod:`propcache <propcache.api>` package is derived from the property caching
  code in :mod:`yarl` and has been broken out to avoid maintaining it for multiple
  projects.


  *Related issues and pull requests on GitHub:*
  #9394.



- Separated ``aiohttp.http_websocket`` into multiple files to make it easier to maintain -- by :user:`bdraco`.


  *Related issues and pull requests on GitHub:*
  #9542, #9552.




Contributor-facing changes
--------------------------

- Changed diagram images generator from ``blockdiag`` to ``GraphViz``.
  Generating documentation now requires the GraphViz executable to be included in $PATH or sphinx build configuration.


  *Related issues and pull requests on GitHub:*
  #9359.




Miscellaneous internal changes
------------------------------

- Added flake8 settings to avoid some forms of implicit concatenation. -- by :user:`booniepepper`.


  *Related issues and pull requests on GitHub:*
  #7731.



- Enabled keep-alive support on proxies (which was originally disabled several years ago) -- by :user:`Dreamsorcerer`.


  *Related issues and pull requests on GitHub:*
  #8920.



- Changed web entry point to not listen on TCP when only a Unix path is passed -- by :user:`Dreamsorcerer`.


  *Related issues and pull requests on GitHub:*
  #9033.



- Disabled automatic retries of failed requests in :class:`aiohttp.test_utils.TestClient`'s client session
  (which could potentially hide errors in tests) -- by :user:`ShubhAgarwal-dev`.


  *Related issues and pull requests on GitHub:*
  #9141.



- Changed web ``keepalive_timeout`` default to around an hour in order to reduce race conditions on reverse proxies -- by :user:`Dreamsorcerer`.


  *Related issues and pull requests on GitHub:*
  #9285.



- Reduced memory required for stream objects created during the client request lifecycle -- by :user:`bdraco`.


  *Related issues and pull requests on GitHub:*
  #9407.



- Improved performance of the internal ``DataQueue`` -- by :user:`bdraco`.


  *Related issues and pull requests on GitHub:*
  #9659.



- Improved performance of calling ``receive`` for WebSockets for the most common message types -- by :user:`bdraco`.


  *Related issues and pull requests on GitHub:*
  #9679.



- Replace internal helper methods ``method_must_be_empty_body`` and ``status_code_must_be_empty_body`` with simple `set` lookups -- by :user:`bdraco`.


  *Related issues and pull requests on GitHub:*
  #9722.



- Improved performance of :py:class:`aiohttp.BaseConnector` when there is no ``limit_per_host`` -- by :user:`bdraco`.


  *Related issues and pull requests on GitHub:*
  #9756.



- Improved performance of sending HTTP requests when there is no body -- by :user:`bdraco`.


  *Related issues and pull requests on GitHub:*
  #9757.



- Improved performance of the ``WebsocketWriter`` when the protocol is not paused -- by :user:`bdraco`.


  *Related issues and pull requests on GitHub:*
  #9796.



- Implemented zero copy writes for ``StreamWriter`` -- by :user:`bdraco`.


  *Related issues and pull requests on GitHub:*
  #9839.




----

-- 
View it on GitHub:
https://github.com/aio-libs/aiohttp/releases/tag/v3.11.0
You are receiving this because you are subscribed to this thread.

Message ID: <aio-libs/aiohttp/releases/185247657@github.com>
----==_mimepart_6734e24d746d5_67193c956bf
Content-Type: text/html;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p></p>
<h1><a href=3D"https://github.com/aio-libs/aiohttp/releases/tag/v3.11.0">=
3.11.0</a></h1><p style=3D"font-size:small;-webkit-text-size-adjust:none;=
">Repository: <a href=3D"https://github.com/aio-libs/aiohttp">aio-libs/ai=
ohttp</a> &middot; Tag: <a href=3D"https://github.com/aio-libs/aiohttp/tr=
ee/v3.11.0">v3.11.0</a> &middot; Commit: <a href=3D"https://github.com/ai=
o-libs/aiohttp/commit/c311912f853651fd70090d11e1dd425824378839">c311912</=
a> &middot; Released by: <a href=3D"https://github.com/apps/github-action=
s">github-actions[bot]</a></p>

<h2>Bug fixes</h2>
<ul>
<li>
<p>Raise :exc:<code>aiohttp.ServerFingerprintMismatch</code> exception on=
 client-side if request through http proxy with mismatching server finger=
print digest: <code>aiohttp.ClientSession(headers=3Dheaders, connector=3D=
TCPConnector(ssl=3Daiohttp.Fingerprint(mismatch_digest), trust_env=3DTrue=
).request(...)</code> -- by :user:<code>gangj</code>.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"1163603010" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/6652" data-hovercard=
-type=3D"issue" data-hovercard-url=3D"/aio-libs/aiohttp/issues/6652/hover=
card" href=3D"https://github.com/aio-libs/aiohttp/issues/6652">#6652</a>.=
</p>
</li>
<li>
<p>Modified websocket :meth:<code>aiohttp.ClientWebSocketResponse.receive=
_str</code>, :py:meth:<code>aiohttp.ClientWebSocketResponse.receive_bytes=
</code>, :py:meth:<code>aiohttp.web.WebSocketResponse.receive_str</code> =
&amp; :py:meth:<code>aiohttp.web.WebSocketResponse.receive_bytes</code> m=
ethods to raise new :py:exc:<code>aiohttp.WSMessageTypeError</code> excep=
tion, instead of generic :py:exc:<code>TypeError</code>, when websocket m=
essages of incorrect types are received -- by :user:<code>ara-25</code>.<=
/p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"1279863029" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/6800" data-hovercard=
-type=3D"issue" data-hovercard-url=3D"/aio-libs/aiohttp/issues/6800/hover=
card" href=3D"https://github.com/aio-libs/aiohttp/issues/6800">#6800</a>.=
</p>
</li>
<li>
<p>Made <code>TestClient.app</code> a <code>Generic</code> so type checke=
rs will know the correct type (avoiding unneeded <code>client.app is not =
None</code> checks) -- by :user:<code>Dreamsorcerer</code>.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2499705055" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/8977" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/8977/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/8977">#8977</=
a>.</p>
</li>
<li>
<p>Fixed the keep-alive connection pool to be FIFO instead of LIFO -- by =
:user:<code>bdraco</code>.</p>
<p>Keep-alive connections are more likely to be reused before they discon=
nect.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2634194393" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/9672" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/9672/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9672">#9672</=
a>.</p>
</li>
</ul>
<h2>Features</h2>
<ul>
<li>
<p>Added <code>strategy</code> parameter to :meth:<code>aiohttp.web.Strea=
mResponse.enable_compression</code><br>
The value of this parameter is passed to the :func:<code>zlib.compressobj=
</code> function, allowing people<br>
to use a more sufficient compression algorithm for their data served by :=
mod:<code>aiohttp.web</code><br>
-- by :user:<code>shootkin</code></p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"1046483756" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/6257" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/6257/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/6257">#6257</=
a>.</p>
</li>
<li>
<p>Added <code>server_hostname</code> parameter to <code>ws_connect</code=
>.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2023291164" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/7941" data-hovercard=
-type=3D"issue" data-hovercard-url=3D"/aio-libs/aiohttp/issues/7941/hover=
card" href=3D"https://github.com/aio-libs/aiohttp/issues/7941">#7941</a>.=
</p>
</li>
<li>
<p>Exported :py:class:<code>~aiohttp.ClientWSTimeout</code> to top-level =
namespace -- by :user:<code>Dreamsorcerer</code>.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2449298331" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/8612" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/8612/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/8612">#8612</=
a>.</p>
</li>
<li>
<p>Added <code>secure</code>/<code>httponly</code>/<code>samesite</code> =
parameters to <code>.del_cookie()</code> -- by :user:<code>Dreamsorcerer<=
/code>.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2498910978" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/8956" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/8956/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/8956">#8956</=
a>.</p>
</li>
<li>
<p>Updated :py:class:<code>~aiohttp.ClientSession</code>'s auth logic to =
include default auth only if the request URL's origin matches _base_url; =
otherwise, the auth will not be included -- by :user:<code>MaximZemskov</=
code></p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2499323329" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/8966" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/8966/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/8966">#8966</=
a>, <a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to lo=
ad title" data-id=3D"2581424502" data-permission-text=3D"Title is private=
" data-url=3D"https://github.com/aio-libs/aiohttp/issues/9466" data-hover=
card-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/9=
466/hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9466">#94=
66</a>.</p>
</li>
<li>
<p>Added <code>proxy</code> and <code>proxy_auth</code> parameters to :py=
:class:<code>~aiohttp.ClientSession</code> -- by :user:<code>meshya</code=
>.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2539010463" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/9207" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/9207/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9207">#9207</=
a>.</p>
</li>
<li>
<p>Added <code>default_to_multipart</code> parameter to <code>FormData</c=
ode>.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2554907013" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/9335" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/9335/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9335">#9335</=
a>.</p>
</li>
<li>
<p>Added :py:meth:<code>~aiohttp.ClientWebSocketResponse.send_frame</code=
> and :py:meth:<code>~aiohttp.web.WebSocketResponse.send_frame</code> for=
 WebSockets -- by :user:<code>bdraco</code>.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2555006041" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/9348" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/9348/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9348">#9348</=
a>.</p>
</li>
<li>
<p>Updated :py:class:<code>~aiohttp.ClientSession</code> to support paths=
 in <code>base_url</code> parameter.<br>
<code>base_url</code> paths must end with a <code>/</code>  -- by :user:<=
code>Cycloctane</code>.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2609530721" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/9530" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/9530/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9530">#9530</=
a>.</p>
</li>
<li>
<p>Improved performance of reading WebSocket messages with a Cython imple=
mentation -- by :user:<code>bdraco</code>.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2616124366" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/9543" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/9543/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9543">#9543</=
a>, <a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to lo=
ad title" data-id=3D"2617508222" data-permission-text=3D"Title is private=
" data-url=3D"https://github.com/aio-libs/aiohttp/issues/9554" data-hover=
card-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/9=
554/hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9554">#95=
54</a>, <a class=3D"issue-link js-issue-link" data-error-text=3D"Failed t=
o load title" data-id=3D"2617688077" data-permission-text=3D"Title is pri=
vate" data-url=3D"https://github.com/aio-libs/aiohttp/issues/9556" data-h=
overcard-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pu=
ll/9556/hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9556"=
>#9556</a>, <a class=3D"issue-link js-issue-link" data-error-text=3D"Fail=
ed to load title" data-id=3D"2617840887" data-permission-text=3D"Title is=
 private" data-url=3D"https://github.com/aio-libs/aiohttp/issues/9558" da=
ta-hovercard-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohtt=
p/pull/9558/hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9=
558">#9558</a>, <a class=3D"issue-link js-issue-link" data-error-text=3D"=
Failed to load title" data-id=3D"2630918005" data-permission-text=3D"Titl=
e is private" data-url=3D"https://github.com/aio-libs/aiohttp/issues/9636=
" data-hovercard-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/ai=
ohttp/pull/9636/hovercard" href=3D"https://github.com/aio-libs/aiohttp/pu=
ll/9636">#9636</a>, <a class=3D"issue-link js-issue-link" data-error-text=
=3D"Failed to load title" data-id=3D"2631055845" data-permission-text=3D"=
Title is private" data-url=3D"https://github.com/aio-libs/aiohttp/issues/=
9649" data-hovercard-type=3D"pull_request" data-hovercard-url=3D"/aio-lib=
s/aiohttp/pull/9649/hovercard" href=3D"https://github.com/aio-libs/aiohtt=
p/pull/9649">#9649</a>, <a class=3D"issue-link js-issue-link" data-error-=
text=3D"Failed to load title" data-id=3D"2647627877" data-permission-text=
=3D"Title is private" data-url=3D"https://github.com/aio-libs/aiohttp/iss=
ues/9781" data-hovercard-type=3D"pull_request" data-hovercard-url=3D"/aio=
-libs/aiohttp/pull/9781/hovercard" href=3D"https://github.com/aio-libs/ai=
ohttp/pull/9781">#9781</a>.</p>
</li>
<li>
<p>Added <code>writer_limit</code> to the :py:class:<code>~aiohttp.web.We=
bSocketResponse</code> to be able to adjust the limit before the writer f=
orces the buffer to be drained -- by :user:<code>bdraco</code>.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2619359048" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/9572" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/9572/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9572">#9572</=
a>.</p>
</li>
<li>
<p>Added an :attr:<code>~aiohttp.abc.AbstractAccessLogger.enabled</code> =
property to :class:<code>aiohttp.abc.AbstractAccessLogger</code> to dynam=
ically check if logging is enabled -- by :user:<code>bdraco</code>.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2650293848" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/9822" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/9822/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9822">#9822</=
a>.</p>
</li>
</ul>
<h2>Deprecations (removal in next major release)</h2>
<ul>
<li>
<p>Deprecate obsolete <code>timeout: float</code> and <code>receive_timeo=
ut: Optional[float]</code> in :py:meth:<code>~aiohttp.ClientSession.ws_co=
nnect</code>. Change default websocket receive timeout from <code>None</c=
ode> to <code>10.0</code>.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"473431785" data-permission-text=3D"Title is private" dat=
a-url=3D"https://github.com/aio-libs/aiohttp/issues/3945" data-hovercard-=
type=3D"issue" data-hovercard-url=3D"/aio-libs/aiohttp/issues/3945/hoverc=
ard" href=3D"https://github.com/aio-libs/aiohttp/issues/3945">#3945</a>.<=
/p>
</li>
</ul>
<h2>Removals and backward incompatible breaking changes</h2>
<ul>
<li>
<p>Dropped support for Python 3.8 -- by :user:<code>Dreamsorcerer</code>.=
</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2476293938" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/8797" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/8797/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/8797">#8797</=
a>.</p>
</li>
<li>
<p>Increased minimum yarl version to 1.17.0 -- by :user:<code>bdraco</cod=
e>.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2487782729" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/8909" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/8909/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/8909">#8909</=
a>, <a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to lo=
ad title" data-id=3D"2512735613" data-permission-text=3D"Title is private=
" data-url=3D"https://github.com/aio-libs/aiohttp/issues/9079" data-hover=
card-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/9=
079/hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9079">#90=
79</a>, <a class=3D"issue-link js-issue-link" data-error-text=3D"Failed t=
o load title" data-id=3D"2551849205" data-permission-text=3D"Title is pri=
vate" data-url=3D"https://github.com/aio-libs/aiohttp/issues/9305" data-h=
overcard-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pu=
ll/9305/hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9305"=
>#9305</a>, <a class=3D"issue-link js-issue-link" data-error-text=3D"Fail=
ed to load title" data-id=3D"2619551566" data-permission-text=3D"Title is=
 private" data-url=3D"https://github.com/aio-libs/aiohttp/issues/9574" da=
ta-hovercard-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohtt=
p/pull/9574/hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9=
574">#9574</a>.</p>
</li>
<li>
<p>Removed the <code>is_ipv6_address</code> and <code>is_ip4_address</cod=
e> helpers are they are no longer used -- by :user:<code>bdraco</code>.</=
p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2554978172" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/9344" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/9344/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9344">#9344</=
a>.</p>
</li>
<li>
<p>Changed <code>ClientRequest.connection_key</code> to be a <code>NamedT=
uple</code> to improve client performance -- by :user:<code>bdraco</code>=
.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2558042958" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/9365" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/9365/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9365">#9365</=
a>.</p>
</li>
<li>
<p><code>FlowControlDataQueue</code> has been replaced with the <code>Web=
SocketDataQueue</code> -- by :user:<code>bdraco</code>.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2636692279" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/9685" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/9685/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9685">#9685</=
a>.</p>
</li>
<li>
<p>Changed <code>ClientRequest.request_info</code> to be a <code>NamedTup=
le</code> to improve client performance -- by :user:<code>bdraco</code>.<=
/p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2639753554" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/9692" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/9692/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9692">#9692</=
a>.</p>
</li>
</ul>
<h2>Packaging updates and notes for downstreams</h2>
<ul>
<li>
<p>Switched to using the :mod:<code>propcache &lt;propcache.api&gt;</code=
> package for property caching<br>
-- by :user:<code>bdraco</code>.</p>
<p>The :mod:<code>propcache &lt;propcache.api&gt;</code> package is deriv=
ed from the property caching<br>
code in :mod:<code>yarl</code> and has been broken out to avoid maintaini=
ng it for multiple<br>
projects.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2562255811" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/9394" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/9394/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9394">#9394</=
a>.</p>
</li>
<li>
<p>Separated <code>aiohttp.http_websocket</code> into multiple files to m=
ake it easier to maintain -- by :user:<code>bdraco</code>.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2616102884" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/9542" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/9542/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9542">#9542</=
a>, <a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to lo=
ad title" data-id=3D"2617208207" data-permission-text=3D"Title is private=
" data-url=3D"https://github.com/aio-libs/aiohttp/issues/9552" data-hover=
card-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/9=
552/hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9552">#95=
52</a>.</p>
</li>
</ul>
<h2>Contributor-facing changes</h2>
<ul>
<li>
<p>Changed diagram images generator from <code>blockdiag</code> to <code>=
GraphViz</code>.<br>
Generating documentation now requires the GraphViz executable to be inclu=
ded in $PATH or sphinx build configuration.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2557343128" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/9359" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/9359/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9359">#9359</=
a>.</p>
</li>
</ul>
<h2>Miscellaneous internal changes</h2>
<ul>
<li>
<p>Added flake8 settings to avoid some forms of implicit concatenation. -=
- by :user:<code>booniepepper</code>.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"1950495145" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/7731" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/7731/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/7731">#7731</=
a>.</p>
</li>
<li>
<p>Enabled keep-alive support on proxies (which was originally disabled s=
everal years ago) -- by :user:<code>Dreamsorcerer</code>.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2489419031" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/8920" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/8920/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/8920">#8920</=
a>.</p>
</li>
<li>
<p>Changed web entry point to not listen on TCP when only a Unix path is =
passed -- by :user:<code>Dreamsorcerer</code>.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2508860833" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/9033" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/9033/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9033">#9033</=
a>.</p>
</li>
<li>
<p>Disabled automatic retries of failed requests in :class:<code>aiohttp.=
test_utils.TestClient</code>'s client session<br>
(which could potentially hide errors in tests) -- by :user:<code>ShubhAga=
rwal-dev</code>.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2525648450" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/9141" data-hovercard=
-type=3D"issue" data-hovercard-url=3D"/aio-libs/aiohttp/issues/9141/hover=
card" href=3D"https://github.com/aio-libs/aiohttp/issues/9141">#9141</a>.=
</p>
</li>
<li>
<p>Changed web <code>keepalive_timeout</code> default to around an hour i=
n order to reduce race conditions on reverse proxies -- by :user:<code>Dr=
eamsorcerer</code>.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2545962147" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/9285" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/9285/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9285">#9285</=
a>.</p>
</li>
<li>
<p>Reduced memory required for stream objects created during the client r=
equest lifecycle -- by :user:<code>bdraco</code>.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2564450287" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/9407" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/9407/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9407">#9407</=
a>.</p>
</li>
<li>
<p>Improved performance of the internal <code>DataQueue</code> -- by :use=
r:<code>bdraco</code>.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2631569722" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/9659" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/9659/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9659">#9659</=
a>.</p>
</li>
<li>
<p>Improved performance of calling <code>receive</code> for WebSockets fo=
r the most common message types -- by :user:<code>bdraco</code>.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2636186316" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/9679" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/9679/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9679">#9679</=
a>.</p>
</li>
<li>
<p>Replace internal helper methods <code>method_must_be_empty_body</code>=
 and <code>status_code_must_be_empty_body</code> with simple <code>set</c=
ode> lookups -- by :user:<code>bdraco</code>.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2645839341" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/9722" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/9722/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9722">#9722</=
a>.</p>
</li>
<li>
<p>Improved performance of :py:class:<code>aiohttp.BaseConnector</code> w=
hen there is no <code>limit_per_host</code> -- by :user:<code>bdraco</cod=
e>.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2646622672" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/9756" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/9756/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9756">#9756</=
a>.</p>
</li>
<li>
<p>Improved performance of sending HTTP requests when there is no body --=
 by :user:<code>bdraco</code>.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2646664837" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/9757" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/9757/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9757">#9757</=
a>.</p>
</li>
<li>
<p>Improved performance of the <code>WebsocketWriter</code> when the prot=
ocol is not paused -- by :user:<code>bdraco</code>.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2647996988" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/9796" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/9796/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9796">#9796</=
a>.</p>
</li>
<li>
<p>Implemented zero copy writes for <code>StreamWriter</code> -- by :user=
:<code>bdraco</code>.</p>
<p><em>Related issues and pull requests on GitHub:</em><br>
<a class=3D"issue-link js-issue-link" data-error-text=3D"Failed to load t=
itle" data-id=3D"2652817002" data-permission-text=3D"Title is private" da=
ta-url=3D"https://github.com/aio-libs/aiohttp/issues/9839" data-hovercard=
-type=3D"pull_request" data-hovercard-url=3D"/aio-libs/aiohttp/pull/9839/=
hovercard" href=3D"https://github.com/aio-libs/aiohttp/pull/9839">#9839</=
a>.</p>
</li>
</ul>
<hr>

&mdash;<p>This release has 50 assets:</p><ul><li>aiohttp-3.11.0.tar.gz</l=
i><li>aiohttp-3.11.0-cp39-cp39-win_amd64.whl</li><li>aiohttp-3.11.0-cp39-=
cp39-win32.whl</li><li>aiohttp-3.11.0-cp39-cp39-musllinux_1_2_x86_64.whl<=
/li><li>aiohttp-3.11.0-cp39-cp39-musllinux_1_2_s390x.whl</li><li>aiohttp-=
3.11.0-cp39-cp39-musllinux_1_2_ppc64le.whl</li><li>aiohttp-3.11.0-cp39-cp=
39-musllinux_1_2_i686.whl</li><li>aiohttp-3.11.0-cp39-cp39-musllinux_1_2_=
aarch64.whl</li><li>aiohttp-3.11.0-cp39-cp39-manylinux_2_5_i686.manylinux=
1_i686.manylinux_2_17_i686.manylinux2014_i686.whl</li><li>aiohttp-3.11.0-=
cp39-cp39-manylinux_2_17_x86_64.manylinux2014_x86_64.whl</li><li>aiohttp-=
3.11.0-cp39-cp39-manylinux_2_17_s390x.manylinux2014_s390x.whl</li><li>aio=
http-3.11.0-cp39-cp39-manylinux_2_17_ppc64le.manylinux2014_ppc64le.whl</l=
i><li>aiohttp-3.11.0-cp39-cp39-manylinux_2_17_aarch64.manylinux2014_aarch=
64.whl</li><li>aiohttp-3.11.0-cp39-cp39-macosx_11_0_arm64.whl</li><li>aio=
http-3.11.0-cp39-cp39-macosx_10_9_x86_64.whl</li><li>aiohttp-3.11.0-cp39-=
cp39-macosx_10_9_universal2.whl</li><li>aiohttp-3.11.0-cp313-cp313-win_am=
d64.whl</li><li>aiohttp-3.11.0-cp313-cp313-win32.whl</li><li>aiohttp-3.11=
.0-cp313-cp313-musllinux_1_2_x86_64.whl</li><li>aiohttp-3.11.0-cp313-cp31=
3-musllinux_1_2_s390x.whl</li><li>aiohttp-3.11.0-cp313-cp313-musllinux_1_=
2_ppc64le.whl</li><li>aiohttp-3.11.0-cp313-cp313-musllinux_1_2_i686.whl</=
li><li>aiohttp-3.11.0-cp313-cp313-musllinux_1_2_aarch64.whl</li><li>aioht=
tp-3.11.0-cp313-cp313-manylinux_2_5_i686.manylinux1_i686.manylinux_2_17_i=
686.manylinux2014_i686.whl</li><li>aiohttp-3.11.0-cp313-cp313-manylinux_2=
_17_x86_64.manylinux2014_x86_64.whl</li><li>aiohttp-3.11.0-cp313-cp313-ma=
nylinux_2_17_s390x.manylinux2014_s390x.whl</li><li>aiohttp-3.11.0-cp313-c=
p313-manylinux_2_17_ppc64le.manylinux2014_ppc64le.whl</li><li>aiohttp-3.1=
1.0-cp313-cp313-manylinux_2_17_aarch64.manylinux2014_aarch64.whl</li><li>=
aiohttp-3.11.0-cp313-cp313-macosx_11_0_arm64.whl</li><li>aiohttp-3.11.0-c=
p313-cp313-macosx_10_13_x86_64.whl</li><li>aiohttp-3.11.0-cp313-cp313-mac=
osx_10_13_universal2.whl</li><li>aiohttp-3.11.0-cp312-cp312-win_amd64.whl=
</li><li>aiohttp-3.11.0-cp312-cp312-win32.whl</li><li>aiohttp-3.11.0-cp31=
2-cp312-musllinux_1_2_x86_64.whl</li><li>aiohttp-3.11.0-cp312-cp312-musll=
inux_1_2_s390x.whl</li><li>aiohttp-3.11.0-cp312-cp312-musllinux_1_2_ppc64=
le.whl</li><li>aiohttp-3.11.0-cp312-cp312-musllinux_1_2_i686.whl</li><li>=
aiohttp-3.11.0-cp312-cp312-musllinux_1_2_aarch64.whl</li><li>aiohttp-3.11=
.0-cp312-cp312-manylinux_2_5_i686.manylinux1_i686.manylinux_2_17_i686.man=
ylinux2014_i686.whl</li><li>aiohttp-3.11.0-cp312-cp312-manylinux_2_17_x86=
_64.manylinux2014_x86_64.whl</li><li>aiohttp-3.11.0-cp312-cp312-manylinux=
_2_17_s390x.manylinux2014_s390x.whl</li><li>aiohttp-3.11.0-cp312-cp312-ma=
nylinux_2_17_ppc64le.manylinux2014_ppc64le.whl</li><li>aiohttp-3.11.0-cp3=
12-cp312-manylinux_2_17_aarch64.manylinux2014_aarch64.whl</li><li>aiohttp=
-3.11.0-cp312-cp312-macosx_11_0_arm64.whl</li><li>aiohttp-3.11.0-cp312-cp=
312-macosx_10_13_x86_64.whl</li><li>aiohttp-3.11.0-cp312-cp312-macosx_10_=
13_universal2.whl</li><li>aiohttp-3.11.0-cp311-cp311-win_amd64.whl</li><l=
i>aiohttp-3.11.0-cp311-cp311-win32.whl</li><li>Source code (zip)</li><li>=
Source code (tar.gz)</li></ul><p>Visit the <a href=3D"https://github.com/=
aio-libs/aiohttp/releases/tag/v3.11.0">release page</a> to download them.=
</p>

<p style=3D"font-size:small;-webkit-text-size-adjust:none;color:#666;">&m=
dash;<br />You are receiving this because you are watching this repositor=
y.<br /><a href=3D"https://github.com/aio-libs/aiohttp/releases/tag/v3.11=
.0">View it on GitHub</a> or <a href=3D"https://github.com/aio-libs/aioht=
tp/unsubscribe_via_email/AA2DE63NNNOTBKRHF6C3F3T2AOEE3ANCNFSM4AGKJU3Q">un=
subscribe</a> from all notifications for this repository.<img src=3D"http=
s://github.com/notifications/beacon/AA2DE64J2EKSNJ3Z5H6TV5D2AOEE3A5CNFSM6=
AAAAABRXAWMCKWGG33NNVSW45C7OR4XAZNHKJSWYZLBONS2UY3PNVWWK3TUL5UWJTQLBKT2S.=
gif" height=3D"1" width=3D"1" alt=3D"" /></p>
<script type=3D"application/ld+json">[
{
"@context": "http://schema.org",
"@type": "EmailMessage",
"potentialAction": {
"@type": "ViewAction",
"target": "https://github.com/aio-libs/aiohttp/releases/tag/v3.11.0",
"url": "https://github.com/aio-libs/aiohttp/releases/tag/v3.11.0",
"name": "View Release"
},
"description": "View this Release on GitHub",
"publisher": {
"@type": "Organization",
"name": "GitHub",
"url": "https://github.com"
}
}
]</script>=

----==_mimepart_6734e24d746d5_67193c956bf--

--0000000000000270200626d2c02d--

